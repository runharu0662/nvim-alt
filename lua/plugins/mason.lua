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
				-- "clangd",
				"pyright",
				"tsserver",
				"jsonls",
				"html",
				"cssls",
				"gopls",
				-- "rust_analyzer",
				"bashls",
				-- "dockerls",
				"yamlls",
			},
			automatic_installation = true,
		})
		require("mason-lspconfig").setup_handlers({
			function(server_name)
				require("lspconfig")[server_name].setup({})
			end,
		})
	end,
}
