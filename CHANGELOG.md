# Noahvim Info

## Changelog

Generated with `git log origin/<branch>..<branch> --pretty=format:"- [%h]: %s"`

### Version 2023.07.25.dev

> This update revolves around lua/noahvim/cmds.lua and creating menus for frequently-used commands.

- [78dc121]: feat(cmds): add git_menu
- [0734d34]: feat(util): trim linebreak from get_current_branch_name
- [0c70e73]: feat(util): add get_current_branch_name
- [7a9956f]: chore: update keymaps
- [604ab33]: feat(cmds): add info_window
- [96e1e29]: refactor(cmds): abstract out create_window_from_file
- [fd5e6a5]: fix(keybinds): too many arguments for buffers
- [3c5de56]: feat(keybinds): add buffer navigation
- [e16fb73]: fix(telescope): correct typo in buffers keymap
- [b88e29c]: refactor(dashboard): abstract out resize function
- [513e1c8]: feat(util): find_buffer_by_name
- [bee0dfb]: refactor(noahvim): move noahvim_menu to cmds

### Version 2023.07.24

First version, various updates. Highlights:

**Keymaps**

See [./noahvim-keymaps.md](./noahvim-keymaps.md)

**Plugins**

Managed by lazy.nvim

- plenary
- everforest (colorscheme) + config
- nvim-web-devicons
- nvim-colorizer + config
- nvim-autopairs
- bufferline + config
- lualine + config
- nvim-notify + config
- gitsigns + config
- nvim-treesitter + config
- telescope + config
- telescoe-file-browser
- nvim-tree + config
- nvim-lspconfig
- mason + config
- mason-lspconfig + config
- cmp-nvim-lsp
- cmp-buffer
- cmp-path
- cmp-cmdline
- nvim-cmp + config
- luasnip
- vimtex + config
