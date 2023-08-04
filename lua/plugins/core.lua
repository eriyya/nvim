return {
	{ 'tpope/vim-surround' },
	-- { 'jiangmiao/auto-pairs' },
    { 'Raimondi/delimitMate' },
	{
		'nvim-tree/nvim-tree.lua',
		config = function()
			require('nvim-tree').setup()
		end
	}
}
