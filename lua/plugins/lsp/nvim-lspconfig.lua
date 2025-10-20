return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lspconfig = require("lspconfig")
		if not lspconfig then
			return
		end -- 念のため

		local servers = {
			clangd = {},
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = { checkThirdParty = false },
					},
				},
			},
			pyright = {},
			jsonls = {},
			html = {},
			cssls = {},
			gopls = {},
			bashls = {},
			yamlls = {},
			rust_analyzer = {},
		}

		for name, opts in pairs(servers) do
			lspconfig[name].setup(opts)
		end
	end,
}
