-- keybinds.lua
-- keybind configurations

-- leader
vim.keymap.set({ 'n', 'v' }, ",", "<Nop>", { noremap = true })
vim.g.mapleader = ","

-- keybinds
local keybinds = {

}

-- set keybinds
for _, v in pairs(keybinds) do
  local opts = {
    noremap = true,
    silent = true
  }
  if v.desc then
    opts.desc = v.desc
  end

  vim.keymap.set(v[1], v[2], v[3], opts)
end
