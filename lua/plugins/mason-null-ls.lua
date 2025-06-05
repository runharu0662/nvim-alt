return {
	"jay-babu/mason-null-ls.nvim",
	lazy = false,
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"nvimtools/none-ls.nvim",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		local mason_null_ls = require("mason-null-ls")

		-- format on save
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

		-- mason-null-ls
		mason_null_ls.setup({
			ensure_installed = {
				"stylua",
				"prettier",
				"clang-format",
				"cpplint",
				"eslint_d",
				"golangci-lint",
				"stylelint",
			},
			handlers = {}, -- automatically register handlers for installed tools
		})
	end,
}
