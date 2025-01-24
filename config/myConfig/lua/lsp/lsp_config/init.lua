local lspconfig = require('lspconfig')
local lspformat = require('lsp-format')

lspformat.setup {}

lspconfig.lua_ls.setup {
  on_attach = lspformat.on_attach
}

lspconfig.clangd.setup {
  on_attach = lspformat.on_attach
}

lspconfig.eslint.setup {
  on_attach = lspformat.on_attach
}

lspconfig.glsl_analyzer.setup {
  on_attach = lspformat.on_attach
}

lspconfig.hls.setup {
  on_attach = lspformat.on_attach
}

lspconfig.nixd.setup {
  cmd = { "nixd" },
}

vim.diagnostic.config({
  virtual_text = true, -- This enables virtual text
})
