-- llm.lua
-- llm integration
-- mostly ripped from yacine

local M = {}

local Job = require "plenary.job"

M.get_api_key = function(name)
  return os.getenv(name)
end

local function write_data(data)
  vim.schedule(function()
    local window = vim.api.nvim_get_current_win()
    local position = vim.api.nvim_win_get_cursor(window)
    local row, col = position[1], position[2]

    local lines = vim.split(data, "\n")

    vim.cmd("undojoin")
    vim.api.nvim_put(lines, "c", true, true)

    local nlines = #lines
    local lastlen = #lines[nlines]
    vim.api.nvim_win_set_cursor(window, { row + nlines - 1, col + lastlen })
  end)
end

M.get_lines = function()
  local buffer = vim.api.nvim_get_current_buf()
  local window = vim.api.nvim_get_current_win()
  local position = vim.api.nvim_win_get_cursor(window)
  local row = position[1]

  local lines = vim.api.nvim_buf_get_lines(buffer, 0, row, true)

  return table.concat(lines, "\n")
end

M.get_selection = function()
  if not table.unpack then
    table.unpack = unpack
  end

  local _, srow, scol = table.unpack(vim.fn.getpos 'v')
  local _, erow, ecol = table.unpack(vim.fn.getpos '.')

  if vim.fn.mode() == 'V' then
    if srow > erow then
      return vim.api.nvim_buf_get_lines(0, erow - 1, srow, true)
    else
      return vim.api.nvim_buf_get_lines(0, srow - 1, erow, true)
    end
  end

  if vim.fn.mode() == 'v' then
    if srow < erow or (srow == erow and scol <= ecol) then
      return vim.api.nvim_buf_get_text(0, srow - 1, scol - 1, erow - 1, ecol, {})
    else
      return vim.api.nvim_buf_get_text(0, erow - 1, ecol - 1, srow - 1, scol, {})
    end
  end

  if vim.fn.mode() == '\22' then
    local lines = {}
    if srow > erow then
      srow, erow = erow, srow
    end
    if scol > ecol then
      scol, ecol = ecol, scol
    end
    for i = srow, erow do
      table.insert(lines, vim.api.nvim_buf_get_text(0, i - 1, math.min(scol - 1, ecol), i - 1, math.max(scol - 1, ecol), {})[1])
    end
    return lines
  end
end

M.get_prompt = function(opts)
  local lines = M.get_selection()
  local prompt = ""

  if lines then
    prompt = table.concat(lines, "\n")
    if opts.replace then
      vim.api.nvim_command("normal! d")
      vim.api.nvim_command("normal! k")
    else
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', false, true, true), 'nx', false)
    end
  else
    prompt = M.get_lines()
  end

  return prompt
end

M.make_groq_request = function(opts, prompt)
  local api_key = opts.api_key_name and M.get_api_key(opts.api_key_name)

  local data = {
    messages = {
      {
        role = "system",
        content = opts.system_prompt
      }, {
        role = "user",
        content = prompt
      }
    },
    model = opts.model,
    temperature = 1.0,
    max_tokens = 1024,
    top_p = 1,
    stream = true,
    stop = nil,
    seed = 1121
  }

  local args = {
    "-X", "POST",
    "-H", "Content-Type: application/json",
    "-H", "Authorization: Bearer " .. api_key,
    "-d", vim.json.encode(data),
    opts.url
  }

  return args
end

M.handle_groq_response = function(stream)
  if stream:match('"delta":') then
    local json = vim.json.decode(stream)
    if json.choices and json.choices[1] and json.choices[1].delta then
      local content = json.choices[1].delta.content
      if content then
        write_data(content)
      end
    end
  end
end

local group = vim.api.nvim_create_augroup("LLMAugroup", {
  clear = true
})

local active_job = nil

M.invoke = function(opts, spec_fn, handler_fn)
  vim.api.nvim_clear_autocmds({
    group = group
  })

  local prompt = M.get_prompt(opts)
  local args = spec_fn(opts, prompt)
  local state = nil

  local function parse_and_call(line)
    local event = line:match("^event: (.+)$")
    if event then
      state = event
    end
    local data = line:match("^data: (.+)$")
    print(line)
    if data then
      handler_fn(data, state)
    end
  end

  if active_job then
    active_job:shutdown()
    active_job = nil
  end

  active_job = Job:new({
    command = "curl",
    args = args,
    on_stdout = function(_, out)
      parse_and_call(out)
    end,
    on_stderr = function(_, _) end,
    on_exit = function()
      active_job = nil
    end
  })

  active_job:start()

  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "LLMEscape",
    callback = function()
      if active_job then
        active_job:shutdown()
        active_job = nil
      end
    end
  })

  vim.keymap.set("n", "<ESC>", ":doautocmd User LLMEscape<CR>", { noremap = true, silent = true })
end

return M
