return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local ok, lspconfig = pcall(require, "lspconfig")
		if not ok then
			vim.notify("nvim-lspconfig not found", vim.log.levels.ERROR)
			return
		end

		-- LSP server setup
		local servers = {
			"lua_ls",
			"pyright",
			"jsonls",
			"html",
			"cssls",
			"gopls",
			"bashls",
			"yamlls",
			"rust_analyzer",
			"clangd",
		}

		for _, server in ipairs(servers) do
			local opts = {}

			if server == "lua_ls" then
				opts = {
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
							workspace = { checkThirdParty = false },
						},
					},
				}
			end

			if lspconfig[server] then
				lspconfig[server].setup(opts)
			else
				vim.notify("Server not found: " .. server, vim.log.levels.WARN)
			end
		end
	end,
}
