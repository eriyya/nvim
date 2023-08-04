return {
	{ 'tpope/vim-surround' },
	-- { 'jiangmiao/auto-pairs' },
	{
		'nvim-tree/nvim-tree.lua',
		config = function()
			require('nvim-tree').setup()
		end
	}
}
