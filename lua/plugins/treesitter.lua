return{
{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local ts_conf = require("nvim-treesitter.configs")
            vim.treesitter.language.register('markdown', { 'markdown', 'quarto', 'rmd' })
			ts_conf.setup({
				ensure_installed = {"r", "matlab", "markdown", "markdown_inline", "latex", "lua", "python", "cpp"},
				highlight = { enable = true },
			})
		end,
	}
}
