return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lspconfig = require("lspconfig")

		lspconfig.clangd.setup({
			cmd = { "clangd" },
			filetypes = { "c", "cpp", "objc", "objcpp" },
			root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"),
		})
		lspconfig.tsserver.setup({})
	end,
}
