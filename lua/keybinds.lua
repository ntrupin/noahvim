-- keybinds.lua
-- keybind configurations

-- leader
vim.keymap.set({ 'n', 'v' }, ",", "<Nop>", { noremap = true })
vim.g.mapleader = ","

-- keybinds
local keybinds = {}

-- set keybinds
for k, v in pairs(keybinds) do
  local opts = {
    noremap = true,
    silent = true
  }
  if v.desc then
    opts.desc = v.desc
  end

  for _, keybind in pairs(keybinds) do
    local lhs = keybind.lhs or keybind[1]
    vim.keymap.set(keybind.mode, lhs, keybind.rhs, opts)
  end
end
