-- tree.lua
-- nvim-tree configuration

local M = {}

-- custom on_attach function 
local function on_attach(bufnr)
  local api = require("nvim-tree.api")

  -- default keybinds
  api.config.mappings.default_on_attach(bufnr)
end

M.config = function()
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  require("nvim-tree").setup({
    -- don't show directories in live filter 
    live_filter = {
      prefix = "[FILTER]: ",
      always_show_folders = false
    },
    on_attach = on_attach
  })

  -- open nvim tree
  local function open_nvim_tree(data)
    -- is real file
    local real_file = vim.fn.filereadable(data.file) == 1
    -- is [No Name] buffer
    local no_name = data.file == "" and vim.bo[data.buf].buftype == ""
    -- is directory
    local directory = vim.fn.isdirectory(data.file) == 1

    -- this should probably never occur, but doesn't hurt to be safe
    if not real_file and not no_name and not directory then
      return
    end

    -- change to directory, if directory
    if directory then
      vim.cmd.cd(data.file)
    else
      -- open the tree, find file (without focusing)
      require("nvim-tree.api").tree.toggle({
        focus = false,
        find_file = true
      })
    end

  end

  -- create autocmd for startup
  vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
end

-- create tree action menu
local function tree_actions_menu(node)
  -- actions
  local tree_actions = {
    {
      name = "Create node",
      handler = require("nvim-tree.api").fs.create,
    },
    {
      name = "Remove node",
      handler = require("nvim-tree.api").fs.remove,
    },
    {
      name = "Trash node",
      handler = require("nvim-tree.api").fs.trash,
    },
    {
      name = "Rename node",
      handler = require("nvim-tree.api").fs.rename,
    },
    {
      name = "Fully rename node",
      handler = require("nvim-tree.api").fs.rename_sub,
    },
    {
      name = "Copy",
      handler = require("nvim-tree.api").fs.copy.node,
    },
  }

  local entry_maker = function(menu_item)
    return {
      value = menu_item,
      ordinal = menu_item.name,
      display = menu_item.name
    }
  end

  local finder = require("telescope.finders").new_table({
    results = tree_actions,
    entry_maker = entry_maker
  })

  local sorter = require("telescope.sorters").get_generic_fuzzy_sorter()

  require("telescope.pickers").new({
    prompt_title = "Menu"
  }, {
    finder = finder,
    sorter = sorter,
    attach_mappings = function(prompt_buffer_number)
      local actions = require("telescope.actions")

      -- on select
      actions.select_default:replace(function()
        local state = require("telescope.actions.state")
        local selection = state.get_selected_entry()
        actions.close(prompt_buffer_number)
        selection.value.handler(node)
      end)

      return true
    end
  }):find()
end

-- keybinds
M.keybinds = {
  { "n", "<leader>t", "<CMD>NvimTreeToggle<CR>", "[t]oggle: toggle file explorer" },
  { "n", "<C-Space>", "<NOP>", "show file explorer actions" }
}

return M
