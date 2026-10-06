return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig", -- ← これが重要
	},
	build = ":MasonUpdate",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local mason_ok, mason = pcall(require, "mason")
		if not mason_ok then
			vim.notify("mason.nvim not found", vim.log.levels.ERROR)
			return
		end

		mason.setup({
			ui = { border = "single", check_outdated_packages_on_open = false },
			ensure_installed = {
				-- for telescope
				"ripgrep",
				"fd",
			},
		})

		local mason_lsp_ok, mason_lsp = pcall(require, "mason-lspconfig")
		if not mason_lsp_ok then
			vim.notify("mason-lspconfig not found", vim.log.levels.ERROR)
			return
		end

		mason_lsp.setup({
			ensure_installed = {},
			automatic_enable = false,
		})
	end,
}
