return {
	"hrsh7th/nvim-cmp",
	dependences = {
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		require("config.cmp")({
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
			}),
			vim.lsp.config("*", {
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			}),
		})
	end,
}
