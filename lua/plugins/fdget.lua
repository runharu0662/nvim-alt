return {
	"j-hui/fidget.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
	},
	config = function()
		require("fidget").setup({
			progress = {
				display = {
					progress_icon = { pattern = "meter", period = 1 },
				},
			},
		})
	end,
}
