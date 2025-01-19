-- General keymaps
vim.keymap.set("n", "<leader>w", "<ESC>:w<CR>", { silent = true, desc = "Save file" })
vim.keymap.set("i", "jk", "<ESC>", { silent = true, desc = "Exit insert mode" })
vim.keymap.set("n", "Y", "<ESC>Vy", { silent = true, desc = "Copy line" })

-- Quote wrapping keymaps
vim.keymap.set("v", "<leader><leader>'", "<ESC>`>a'<ESC>`<i'<ESC>", { silent = true, desc = "wrap single quote" })
vim.keymap.set("v", "<leader><leader>\"", "<ESC>`>a\"<ESC>`<i\"<ESC>", { silent = true, desc = "wrap double quote" })
vim.keymap.set("v", "<leader><leader>`", "<ESC>`>a`<ESC>`<i`<ESC>", { silent = true, desc = "wrap backtick" })
