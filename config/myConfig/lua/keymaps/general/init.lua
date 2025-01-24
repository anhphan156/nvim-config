-- General keymaps
vim.keymap.set("n", "<leader>w", "<ESC>:w<CR>", { silent = true, desc = "Save file" })
vim.keymap.set("i", "jk", "<ESC>", { silent = true, desc = "Exit insert mode" })
vim.keymap.set("n", "Y", "<ESC>Vy", { silent = true, desc = "Copy line" })

-- Quote wrapping keymaps
-- Quotes
vim.keymap.set("v", "<leader><leader>'", "<ESC>`>a'<ESC>`<i'<ESC>", { silent = true, desc = "wrap single quote" })
vim.keymap.set("v", "<leader><leader>\"", "<ESC>`>a\"<ESC>`<i\"<ESC>", { silent = true, desc = "wrap double quote" })

-- Escape quotes
vim.keymap.set("v", "<leader><leader>e'", "<ESC>`>a\\'<ESC>`<i\\'<ESC>",
  { silent = true, desc = "wrap escape single quote" })
vim.keymap.set("v", "<leader><leader>e\"", "<ESC>`>a\\\"<ESC>`<i\\\"<ESC>",
  { silent = true, desc = "wrap escape double quote" })

-- Brackets
vim.keymap.set("v", "<leader><leader>(", "<ESC>`>a)<ESC>`<i(<ESC>", { silent = true, desc = "wrap parenthese" })
vim.keymap.set("v", "<leader><leader>[", "<ESC>`>a]<ESC>`<i[<ESC>", { silent = true, desc = "wrap square backet" })
vim.keymap.set("v", "<leader><leader>{", "<ESC>`>a}<ESC>`<i{<ESC>", { silent = true, desc = "wrap curly backet" })

-- Escape brackets
vim.keymap.set("v", "<leader><leader>e(", "<ESC>`>a\\)<ESC>`<i\\(<ESC>",
  { silent = true, desc = "wrap escape parenthese" })

-- Others
vim.keymap.set("v", "<leader><leader>`", "<ESC>`>a`<ESC>`<i`<ESC>", { silent = true, desc = "wrap backtick" })
vim.keymap.set("v", "<leader><leader><", "<ESC>`>a><ESC>`<i<<ESC>", { silent = true, desc = "wrap triangle" })

-- Tmux
vim.keymap.set("n", "<leader>cs", "<CMD>! tmux send-keys -t :.+1 C-c<CR>",
  { silent = true, desc = "Send Control-C to next tmux pane" })
