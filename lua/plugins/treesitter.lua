return{
{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local ts_conf = require("nvim-treesitter.configs")

			ts_conf.setup({
				ensure_installed = {"r", "matlab", "markdown", "markdown_inline", "latex", "lua", "python", "cpp"},
				highlight = { enable = true },
                vim.treesitter.language.register('markdown', 'quarto'),
			})
		end,
	}
}
