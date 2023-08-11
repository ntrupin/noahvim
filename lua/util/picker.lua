-- menus.lua
-- custom menus

local M = {}

-- vim select menu
M.create = function(prompt, entries, opts)
  opts = opts or {}

  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values

  local entry_maker = function(entry)
    return {
      value = {
        name = entry[1],
        handler = entry[2]
      },
      ordinal = entry[1],
      display = entry[1]
    }
  end

  local finder = finders.new_table({
    results = entries,
    entry_maker = entry_maker
  })

  local sorter = conf.generic_sorter(opts)

  local picker_options = {
    prompt_title = prompt,
    finder = finder,
    sorter = sorter,
    attach_mappings = function(prompt_buffer_number)
      local actions = require("telescope.actions")
      -- on select
      actions.select_default:replace(function()
        local state = require("telescope.actions.state")
        local selection = state.get_selected_entry()
        -- close picker
        actions.close(prompt_buffer_number)
        -- execute
        local handler = selection.value.handler
        if handler ~= nil then
          if type(handler) == "string" then
            vim.cmd(handler)
          elseif type(handler) == "function" then
            handler()
          end
        end
      end)

      return true
    end
  }

  pickers.new(opts, picker_options):find()
end

return M
