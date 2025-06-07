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
				["<CR>"] = map.confirm({ select = true }),
				["<Tab>"] = map.confirm({ select = true }),
			}),
			sources = {
				{ name = "copilot", group_index = 1, priority = 1000 },
				{ name = "nvim_lsp", group_index = 2, priority = 750 },
				{ name = "buffer", group_index = 2, priority = 500 },
			},
			sorting = {
				priority_weight = 2,
				comparators = {
					require("copilot_cmp.comparators").prioritize,
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					cmp.config.compare.score,
					cmp.config.compare.kind,
					cmp.config.compare.sort_text,
					cmp.config.compare.length,
					cmp.config.compare.order,
				},
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
