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
				{ name = "copilot" },
				{ name = "nvim_lsp" },
				{ name = "buffer" },
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
		})

		-- capabilities を取得（cmp 統合用）
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- mason-lspconfig で自動セットアップ
		require("mason-lspconfig").setup_handlers({
			function(server_name)
				require("lspconfig")[server_name].setup({
					capabilities = capabilities,
				})
			end,
		})
	end,
}
