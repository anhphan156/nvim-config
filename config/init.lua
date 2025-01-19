-- General keymaps
vim.keymap.set("n", "<leader>w", "<ESC>:w<CR>", { silent = true, desc = "Save file" })
vim.keymap.set("i", "jk", "<ESC>", { silent = true, desc = "Exit insert mode" })
vim.keymap.set("n", "Y", "<ESC>Vy", { silent = true, desc = "Copy line" })

-- Quote wrapping keymaps
vim.keymap.set("v", "<leader><leader>'", "<ESC>`>a'<ESC>`<i'<ESC>", { silent = true, desc = "wrap single quote" })
vim.keymap.set("v", "<leader><leader>\"", "<ESC>`>a\"<ESC>`<i\"<ESC>", { silent = true, desc = "wrap double quote" })
vim.keymap.set("v", "<leader><leader>`", "<ESC>`>a`<ESC>`<i`<ESC>", { silent = true, desc = "wrap backtick" })

-- Colors
vim.cmd('colorscheme tokyonight')
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "Winbar", { bg = "none" })
vim.api.nvim_set_hl(0, "WinbarNC", { bg = "none" })
vim.api.nvim_set_hl(0, "TabLine", { bg = "none" })
vim.api.nvim_set_hl(0, "TabLineSel", { bg = "none" })
vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })

-- Numberline
vim.wo.number = true         -- Show absolute line numbers
vim.wo.relativenumber = true -- Show relative line numbers

-- Indentation settings
vim.o.shiftwidth = 2     -- Number of spaces to use for indentation
vim.o.tabstop = 2        -- Number of spaces a tab represents
vim.o.smartindent = true -- Enable smart indentation
vim.o.expandtab = true   -- Use spaces instead of tabs for indentation

-- Scrolling settings
vim.o.scrolloff = 8 -- Keep 8 lines above and below the cursor while scrolling
vim.o.scl = "yes"   -- Scroll behavior (optional, depends on use case)

-- Autocmd
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.nix",
  callback = function()
    local cursor = vim.api.nvim_win_get_cursor(0) -- Get the current cursor position
    vim.cmd('silent %!alejandra -qq')             -- Run the Alejandra formatter
    vim.api.nvim_win_set_cursor(0, cursor)        -- Restore the cursor position
  end,
})
