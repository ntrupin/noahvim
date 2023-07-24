-- telescope.lua
-- telescope configurations

local M = {}

-- config
M.config = function()
  local previewers = require("telescope.previewers")

  -- ignore large files in preview
  local new_maker = function(filepath, bufnr, opts)
    opts = opts or {}

    filepath = vim.fn.expand(filepath)
    vim.loop.fs_stat(filepath, function(_, stat)
      if not stat then return end
      -- > 100mb
      if stat.size > 100000 then
        -- write an error to buffer
        vim.schedule(function()
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "FILE > 100MB" })
        end)
      else
        previewers.buffer_previewer_maker(filepath, bufnr, opts)
      end
    end)
  end

  require("telescope").setup({
    defaults = {
      buffer_previewer_maker = new_maker
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
