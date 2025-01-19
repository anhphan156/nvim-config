local telescope = require('telescope')

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ["<Esc>"] = require('telescope.actions').close,
      },
    },
  },
}

-- Keymaps
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { silent = true, desc = "Telescope find files" })
