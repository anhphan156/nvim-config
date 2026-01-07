local parsers = {
	'lua',
	'c',
	'rust',
	'bash',
	'nix',
	'git_config',
	'git_rebase',
	'gitcommit',
	'gitignore',
	'diff',
	'make',
	'json',
	'regex',
}

require 'nvim-treesitter'.setup {
	-- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
	install_dir = vim.fn.stdpath('data') .. '/site'
}

vim.defer_fn(function()
	require('nvim-treesitter').install(parsers)
end, 0)

vim.api.nvim_create_autocmd('FileType', {
	pattern = parsers,
	callback = function()
		vim.treesitter.start()
	end,
})
