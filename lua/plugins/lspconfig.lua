return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lspconfig = require("lspconfig")
        local signs = { Error = " ", Warn = " ", Hint = "󱩎 ", Info = " " }
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl })
		lspconfig.clangd.setup({})
	end,
}
