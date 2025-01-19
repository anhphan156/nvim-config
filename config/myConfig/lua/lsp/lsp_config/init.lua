local lspconfig = require('lspconfig')
require("lsp-format").setup {}

lspconfig.lua_ls.setup {
	on_attach = require("lsp-format").on_attach
}

lspconfig.clangd.setup {
	on_attach = require("lsp-format").on_attach
}

lspconfig.nixd.setup {
	cmd = { "nixd" },
}

vim.diagnostic.config({
	virtual_text = true, -- This enables virtual text
})
