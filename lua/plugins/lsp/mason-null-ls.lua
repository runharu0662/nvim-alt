return {
	"jay-babu/mason-null-ls.nvim",
	lazy = false, -- Load immediately; no need for event-based lazy loading
	dependencies = {
		"williamboman/mason.nvim",
		"nvimtools/none-ls.nvim",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		local mason_null_ls = require("mason-null-ls")

		-- Format on save setup
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		null_ls.setup({
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end
			end,
		})

		-- Mason-null-ls integration: auto-install and auto-register tools
		mason_null_ls.setup({
			ensure_installed = {
				"stylua", -- Lua formatter
				"prettier", -- JS, HTML, CSS formatter
				"clang-format", -- C/C++ formatter
				"cpplint", -- C++ linter
				"eslint", -- JS/TS linter
				"golangci-lint", -- Go linter
				"stylelint", -- CSS linter
				"markuplint",
				"stylelint", -- CSS linter
				"goimports", -- Go imports formatter
			},
			handlers = {}, -- Enable automatic registration of installed sources
		})
	end,
}
