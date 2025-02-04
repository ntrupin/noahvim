# Noahvim Info

## Changelog

Generated with `git log <target>/<branch>..<branch> --grep="^chore: " --invert-grep --pretty=format:"- [%h]: %s"`

### Version 2024.07.21

- [0ebb78c]: fix(llm): replace text
- [893495d]: fix(statusline): make divider colorscheme agnostic
- [dabcccd]: feat: add groq llm support

### Version 2023.09.14

> This version focuses on refining custom components and implementing some functionality in C.

- [63e2937]: fix(highlights): switch darken_hex_color to bit32
- [a29275b]: feat: add C ffi && bit32 bridge
- [1fc161f]: feat: add bit32 C library
- [00966e4]: feat(dashboard): change name color
- [c789f2b]: feat(catppuccin): override colors
- [c2c9c2b]: feat(highlights): tweak catppuccin
- [75abf9e]: feat(colorschemes): new colorscheme config
- [f697b39]: feat(plugins): new colorscheme
- [4d75919]: refactor(statusline): change colorscheme
- [6c4c8dc]: refactor(highlights): separate by theme
- [869e680]: refactor(init): change highlight group
- [3921915]: feat(highlights): add inverse mode colors
- [44d802f]: chore(statusline): remove irrelevant comment
- [aad19e2]: feat(statusline): add more modes

### Version 2023.09.10

> This version focuses on implementing custom components instead of relying on plugins.

- [df4c7d7]: fix(tabline): remove name
- [d494a16]: feat: add custom tabline
- [30c58fa]: fix(components): fix nvimtree spacer spacing
- [c2bf3ba]: feat(components): add nvimtree spacer component
- [2090f6a]: fix(statusline): increase spacing
- [0281fb9]: feat(plugins): remove bufferline
- [db08785]: feat(dashboard): more colors
- [3ab5054]: feat(window): accept more opts
- [5c54da1]: feat(notepad): change float location
- [6f041fb]: feat(statusline): increase item spacing
- [1fa1100]: feat(dashboard): color the ducks
- [733d6b7]: feat(highlights): add bold colors
- [0d398b2]: fix(statusline): remove print statement
- [47df8b1]: feat(components): add terminal normal mode
- [b66a902]: feat(highlights): bold status indicators
- [e917574]: fix(components): extra space on git change
- [a80be99]: feat(statusline): show lsp status
- [64a656d]: feat: implement custom statusline
- [ab92ba7]: refactor: move statusline components to separate file
- [d09bc0e]: feat: add custom highlights
- [95f0fec]: fix(plugins): fix colorscheme author
- [0dcc67e]: feat(util): add highlights
- [da77276]: feat(opts): set noshowmode
- [5d308e6]: feat(plugins): revert colorscheme
- [bf87d2a]: feat(colorschemes): add onedarkpro colorscheme
- [7165f92]: feat(plugins): switch to oxocarbon theme
- [f2b0e38]: feat(colorschemes): patch oxocarbon comment font color
- [80019b8]: feat(colorschemes): picker (incomplete)
- [5e94874]: feat(colorschemes): add index file

### Version 2023.08.13

> This update focuses on refactoring project structure and adding user utilities.

- [7af8a12]: refactor(notepad): move spell to window opts
- [6135b2e]: refactor(notepad+window): move notepad logic, more opts
- [f5146dc]: feat(window): allow creation without md file
- [681e10b]: feat(notepad): add launch keybind
- [a192e94]: refactor(plugins): change to setup function
- [0c3b27f]: refactor(config): change to setup function
- [46acb2b]: refactor(util): move to funcs
- [4ad5fb5]: refactor(noahvim): move to ui
- [b358fa6]: refactor(plugins): move configs to config
- [b390af0]: refactor(cmds): move to commands
- [fd1496d]: refactor(plugins): move configs to config
- [bf83297]: refactor(window): move to util
- [d80ed34]: refactor(picker): complete move
- [69712b7]: refactor(picker): move to util
- [540fe40]: fix(notepad): remove insert mode esc binding
- [7e57014]: feat(colorschemes): add oxocarbon config
- [136c135]: feat(notepad): show welcome message on notepad
- [c167414]: feat(tree): actions menu
- [348f53d]: refactor(notepad): rename scratch
- [cd5a579]: fix(scratch): exit insert before closing window
- [d0765b6]: feat(scratch): open into insert mode
- [c06f464]: feat(tree): remove focus keybind
- [1e836d8]: feat(window): allow other filetypes
- [b698707]: fix(window): vertical positioning
- [fc0b784]: feat: add scratchpad
- [8b42693]: fix(opts): change split direction

### Version 2023.08.09

> This update focuses on code quality, filetype rules, and menus.

- [b74c300]: feat(opts): vim indent rules
- [bd38f8e]: feat(opts): tex indent rules
- [f716bca]: fix(dashboard): cursor placement
- [9fcdbee]: fix: assorted typos
- [5c7bc17]: fix: update gitignore
- [486913f]: fix(dashboard): undefined var
- [9d5b4b6]: fix(cmds): improve term_menu verbosity
- [245e257]: feat(cmds): change term_menu commands

### Version 2023.07.26

> This update revolves around lua/noahvim/cmds.lua and creating menus for frequently-used commands.

- [8947c31]: feat(cmds): add credits_window
- [86f693d]: feat(docs): add credits page
- [dd12592]: feat(dashboard): add ducks and credits
- [1666b7a]: feat(keybinds): add menu keybinds
- [fdd9aa6]: feat(cmds): add terminal menu
- [4f623bb]: refactor(docs): rename changelog
- [7cbcdd3]: refactor(docs): move some more
- [9b6a6fe]: refactor(docs): moved files around
- [64bf479]: feat(cmds): add git branch commands
- [7b0fce4]: feat(opts): switch javascript to use 2-space tabs
- [78dc121]: feat(cmds): add git_menu
- [0734d34]: feat(util): trim linebreak from get_current_branch_name
- [0c70e73]: feat(util): add get_current_branch_name
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
