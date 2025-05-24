return {
	"nvimdev/lspsaga.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- optional
		"nvim-tree/nvim-web-devicons", -- optional
	},
	config = function()
		require("lspsaga").setup({
			ui = {
				-- Border type can be single, double, rounded, solid, shadow.
				border = "single",
				-- Title for finder and code action popup
				title = true,
				-- Set the colors of the title icon and text
				title_icon = " ",
			},
		})
	end,
}
