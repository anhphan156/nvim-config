vim.opt_local.shiftwidth = 4 -- Number of spaces to use for indentation
vim.opt_local.tabstop = 4    -- Number of spaces a tab represents

vim.keymap.set("n", "<leader>cc", "<CMD>! tmux send-keys -t :.+1 \" make\" Enter<CR>", {
  noremap = true,
  silent = true,
  buffer = true,
})

vim.keymap.set("n", "<leader>cr", "<CMD>! tmux send-keys -t :.+1 \" make run\" Enter<CR>", {
  noremap = true,
  silent = true,
  buffer = true,
})

vim.keymap.set("n", "<leader>cl", "<CMD>! tmux send-keys -t :.+1 \" make clean\" Enter<CR>", {
  noremap = true,
  silent = true,
  buffer = true,
})

vim.keymap.set("n", "<leader>d", "<CMD>! CDebugTmux<CR>", {
  noremap = true,
  silent = true,
  buffer = true,
})
