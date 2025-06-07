return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"elixir",
				"javascript",
				"html",
				"css",
				"json",
				"yaml",
				"bash",
				"markdown",
				"markdown_inline",
				"python",
				"go",
				"typescript",
				"tsx",
				"dockerfile",
				"sql",
				"graphql",
			},
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
