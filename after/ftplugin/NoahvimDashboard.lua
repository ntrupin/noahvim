-- prevent opening nvimtree from dashboard
vim.keymap.set("n", "<leader>t", "<NOP>", {
  noremap = true,
  silent = true,
  buffer = true
})
