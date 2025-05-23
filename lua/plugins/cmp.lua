return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
	},

	config = function()
		local cmp = require("cmp")
		local map = cmp.mapping

		cmp.setup({
			mapping = map.preset.insert({
				["<C-n>"] = map.complete(),
				["<CR>"] = map.confirm({ select = false }),
			}),
		})

		vim.lsp.config("*", {
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		})
	end,
}
