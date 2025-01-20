vim.keymap.set("n", "<leader>cc", "<CMD>! tmux send-keys -t :.+1 \" nix build\" Enter<CR>", {
  noremap = true,
  silent = true,
  buffer = true,
})

vim.keymap.set("n", "<leader>cr", "<CMD>! tmux send-keys -t :.+1 \" nix run\" Enter<CR>", {
  noremap = true,
  silent = true,
  buffer = true,
})
