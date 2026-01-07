local parsers = {
	'lua',
	'c',
	'rust',
	'bash',
	'nix',
}
require('nvim-treesitter').setup()

vim.defer_fn(function()
	require('nvim-treesitter').install(parsers):wait(300000)
end, 0)

vim.api.nvim_create_autocmd('FileType', {
	pattern = parsers,
	callback = function()
		vim.treesitter.start()
	end,
})
