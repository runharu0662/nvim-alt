return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
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
				"tsserver",
				"jsonls",
				"html",
				"cssls",
				"gopls",
				"bashls",
				"yamlls",
				"rust_analyzer", -- Rust 追加！
			},
		})

		local lspconfig = require("lspconfig")

		lspconfig.lua_ls.setup({})
		lspconfig.pyright.setup({})
		lspconfig.tsserver.setup({})
		lspconfig.jsonls.setup({})
		lspconfig.html.setup({})
		lspconfig.cssls.setup({})
		lspconfig.gopls.setup({})
		lspconfig.bashls.setup({})
		lspconfig.yamlls.setup({})
		lspconfig.rust_analyzer.setup({}) -- Rust 追加！
	end,
}
