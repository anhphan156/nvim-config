local lspconfig = require('lspconfig')
require("lsp-format").setup {}

lspconfig.lua_ls.setup {
  on_attach = require("lsp-format").on_attach
}

lspconfig.clangd.setup {}

lspconfig.nixd.setup {
  cmd = { "nixd" },
}
