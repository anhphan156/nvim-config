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

vim.opt.guicursor =
    "r-v-c-sm:block," ..
    "i-ci-ve:ver25," ..
    "n-cr-o:hor20," ..
    "t:block-blinkon500-blinkoff500-TermCursor"

-- Autocmd
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.nix",
  callback = function()
    local cursor = vim.api.nvim_win_get_cursor(0) -- Get the current cursor position
    vim.cmd('silent %!alejandra -qq')             -- Run the Alejandra formatter
    vim.api.nvim_win_set_cursor(0, cursor)        -- Restore the cursor position
  end,
})

-- Clipboard
vim.opt.clipboard = "unnamedplus"
