return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		require("mason").setup({
			ui = {
				check_outdated_packages_on_open = false,
				border = "single",
			},
		})

		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"pyright",
				"jsonls",
				"html",
				"cssls",
				"gopls",
				"bashls",
				"yamlls",
				"rust_analyzer",
			},
		})

		--------------------------
		-- new lspconfig setup
		local lsp = vim.lsp.config
		-------------------------

		lsp.lua_ls.setup({})
		lsp.pyright.setup({})
		lsp.jsonls.setup({})
		lsp.html.setup({})
		lsp.cssls.setup({})
		lsp.gopls.setup({})
		lsp.bashls.setup({})
		lsp.yamlls.setup({})
		lsp.rust_analyzer.setup({})
	end,
}
