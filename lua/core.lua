-- iterate over pairs, add to vim options
local function set_opts(opts)
  for k, v in pairs(opts) do
    vim.opt[k] = v
  end
end 

-- set "unopinionated" options
do
  -- options accepted as "default" within the Neovim/Vim communities
  -- taken from theopn/theovim
  local unopinionated = {
    -- general
    filetype = "on",
    syntax = "on",
    confirm = true,
    autochdir = false,
    scrolloff = 7,
    showtabline = 2,
    laststatus = 3,
    -- search
    hlsearch = true,
    incsearch = true,
    ignorecase = true,
    smartcase = true,
    -- split pane
    splitright = false,
    splitbelow = true,
    -- appearance
    termguicolors = true,
    mouse = "a",
    list = true,
    listchars = {
      tab = "▷▷",
      trail = "␣",
      nbsp = "⍽"
    },
    -- folding
    foldmethod = "expr",
    foldlevel = 1,
    foldenable = false
    foldexpr = "nvim_treesitter#foldexpr()"
  }

  set_opts(unopinionated)
end 

-- set "opinionated" options
do
  local opinionated = {
    -- tabs as spaces
    tabstop = 4,
    softtabstop = 0,
    expandtab = true,
    shiftwidth = 4,
    -- spellcheck
    spelllang = "en",
    spellsuggest = "best,8"
    spell = false,
  }

  set_opts(opinionated)
end

-- set filetype-specific options
do
  local ftype_specific = {
    lua = {
      tabstop = 2,
      shiftwidth = 2
    }
  } 

  -- make list of ftypes
  local ftypes = {}
  local n = 0
  for k, _ in pairs(ftype_specific) do
    n = n + 1
    ftypes[n] = k
  end

  -- create autocommand
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("FileSettings", { clear = true }),
    pattern = ftypes,
    callback = function()
      for k, v in pairs(ftype_specific[vim.bo.filetype]) do
        vim.opt_local[k] = v
      end
    end
  })
end
