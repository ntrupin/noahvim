-- keybinds.lua
-- keybind configurations

-- leader
vim.keymap.set({ 'n', 'v' }, "<SPACE>", "<Nop>", { noremap = true })
vim.g.mapleader = " "

-- keybinds
local keybinds = {
  -- copy/paste
  { "x", "<leader>y", '"+y', "[y]ank: yank to system clipboard" },
  { "n", "<leader>p", "<CMD>Telescope registers<CR>", "[p]aste: paste from Telescope registers" },

  -- terminal
  { "t", "<ESC>", "<C-\\><C-n>", "[ESC]: exit terminal mode"},

  -- split panes
  { "n", "<leader>|", "<CMD>vsplit<CR><C-w>l", "[|]: create a vertical split" },
  { "n", "<leader>-", "<CMD>split<CR><C-w>j", "[-]: create a horizontal split" },
  -- { "n", "<leader>q", "<C-w>q", "[q]uit: close the selected window" },
  { "n", "<leader>h", "<C-w>h", "[h]: move to the window on the left" },
  { "n", "<leader>j", "<C-w>j", "[j]: move to the window below" },
  { "n", "<leader>k", "<C-w>k", "[k]: move to the window above" },
  { "n", "<leader>l", "<C-w>l", "[l]: move to the window on the right" },
  { "n", "<leader><LEFT>", "<C-w>10<", "[10<]: decrease window width by 10" },
  { "n", "<leader><RIGHT>", "<C-w>10>", "[10>]: increase window width by 10" },
  { "n", "<leader><UP>", "<C-w>5+", "[5+]: increase window height by 5" },
  { "n", "<leader><DOWN>", "<C-w>5-", "[5-]: increase window height by 5"},
  { "n", "<leader>H", "<C-w>H", "[H]: move window to the far left" },
  { "n", "<leader>J", "<C-w>J", "[J]: move window to the bottom" },
  { "n", "<leader>L", "<C-w>L", "[L]: move window to the far right" },

  -- buffers
  { "n", "<leader>[", "<CMD>bprevious<CR>", "[[]: navigate to previous buffer" },
  { "n", "<leader>]", "<CMD>bnext<CR>", "[]]: navigate to next buffer" },

  -- lsp
  { "n", "<leader>cd", function() vim.lsp.buf.hover() end, "[c]ode [d]oc: show lsp hover doc for entity" },
  { "n", "<leader>cr", function() vim.lsp.buf.rename() end, "[c]ode [r]ename: rename entity" },

  -- menus
  { "n", "<leader>m", require("commands").noahvim_menu, "[m]enu: show menu" },
  { "n", "<leader>g", require("commands").git_menu, "[g]it menu: show git menu" },
  { "n", "<leader>z", require("commands").term_menu, "[z]sh menu: show term menu" },
  { "n", "<leader>q", require("commands").noahvim_llm, "groq" },
  { "v", "<leader>q", require("commands").noahvim_llm, "groq" },
  { "n", "<leader>np", require("ui.notepad").launch, "[n]ote[p]ad: launch notepad" },

  table.unpack(require("config.tree").keybinds),
  table.unpack(require("config.telescope").keybinds)
}

-- set keybinds
for _, v in pairs(keybinds) do
  local opts = {
    noremap = true,
    silent = true
  }
  if v[4] then
    opts.desc = v[4]
  end

  -- extra options
  if v[5] then
    for k, val in pairs(v[5]) do
      opts[k] = val
    end
  end

  vim.keymap.set(v[1], v[2], v[3], opts)
end
