return {
	"jay-babu/mason-null-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"nvimtools/none-ls.nvim",
	},
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({})

		require("mason-null-ls").setup({
			automatic_installation = true,
			ensure_installed = {
				"stylua",
				"prettier",
				"clang-format",
			},
			handlers = {
				stylua = function()
					null_ls.register(null_ls.builtins.formatting.stylua)
				end,
				prettier = function()
					null_ls.register(null_ls.builtins.formatting.prettier)
				end,
				clang_format = function()
					null_ls.register(null_ls.builtins.formatting.clang_format)
				end,
			},
		})
	end,
}
