return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lsp = vim.lsp and vim.lsp.config
		if not lsp then
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
			lsp[name].setup(opts) -- 新APIのみ
		end
	end,
}
