return {
	"hrsh7th/nvim-cmp",
	dependences = {
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		require("cmp.setup")({
			mapping = {
				["<C-n>"] = cmp.mapping.complete(),
				["<CR>"] = map.confirm({ select = false }),
			},
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
			}),
			vim.lsp.config("*", {
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			}),
		})
	end,
}
