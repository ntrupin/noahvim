-- telescope.lua
-- telescope configurations

local M = {}

-- config
M.config = function()
  local previewers = require("telescope.previewers")

  -- ignore large files and binaries in preview
  local new_maker = function(filepath, bufnr, opts)
    opts = opts or {}

    filepath = vim.fn.expand(filepath)

    local large_file_found = false

    -- check for large file
    vim.loop.fs_stat(filepath, function(_, stat)
      if not stat then return end
      -- > 100mb
      if stat.size > 100000 then
        -- write an error to buffer
        large_file_found = true
        vim.schedule(function()
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "FILE > 100MB" })
        end)
      else
        previewers.buffer_previewer_maker(filepath, bufnr, opts)
      end
    end)

    if large_file_found then
      return
    end

    -- check for binary
    local Job = require("plenary.job")
    Job:new({
      command = "file",
      args = { "--mime-type", "-b", filepath },
      on_exit = function(j)
        local mime_type = vim.split(j:result()[1], "/")[1]
        if mime_type == "text" then
          previewers.buffer_previewer_maker(filepath, bufnr, opts)
        else
          vim.schedule(function()
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY FILE" })
          end)
        end
      end
    })
  end

  local actions = require("telescope.actions")
  require("telescope").setup({
    defaults = {
      buffer_previewer_maker = new_maker,
      mappings = {
        i = {
          -- map esc to quit in insert mode
          ["<esc>"] = actions.close
        }
      }
    }
  })
end

-- keybinds
M.keybinds = {
  { "n", "<leader>?", "<CMD>Telescope keymaps<CR>", "[?]: show keymaps" },
  { "n", "<leader>ff", "<CMD>Telescope find_files<CR>", "[f]ind [f]iles" },
  { "n", "<leader>fg", "<CMDTelescope live_grep<CR>", "[f][g]rep: live grep" },
  { "n", "<leader>fb", "<CMD>Telescope buffer<CR>", "[f]ind [b]uffers: find buffers" },
  { "n", "<leader>fh", "<CMD>Telescope help_tags<CR>", "[f]ind [h]elp: find help tags" }
}

return M
