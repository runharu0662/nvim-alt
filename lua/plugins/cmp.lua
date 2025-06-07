return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"zbirenbaum/copilot-cmp",
	},
	config = function()
		local cmp = require("cmp")
		local map = cmp.mapping

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
			mapping = map.preset.insert({
				["<C-p>"] = map.select_prev_item(),
				["<C-n>"] = map.select_next_item(),
				["<CR>"] = map.confirm({ select = false }),
				["<Tab>"] = map.confirm({ select = true }),
			}),
			sources = {
				{ name = "nvim_lsp", max_item_count = 15, keyword_length = 2 },
				{ name = "copilot", max_item_count = 15, keyword_length = 2 },
				{ name = "buffer", max_item_count = 15, keyword_length = 2 },
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
		})

		vim.lsp.config("*", {
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		})
	end,
}
