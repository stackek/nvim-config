return{
{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local ts_conf = require("nvim-treesitter.configs")

			ts_conf.setup({
				ensure_installed = { "markdown", "markdown_inline", "latex" },
				highlight = { enable = true },
			})
		end,
	}
}
