return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = {
				"lua",
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"markdown_inline",
				"go",
				"gomod",
				"gosum",
				"gowork",
				"javascript",
				"typescript",
				"tsx",
				"html",
				"css",
				"json",
				"jsonc",
				"hcl",
				"terraform",
				"yaml",
				"dockerfile",
				"bash",
			},
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
