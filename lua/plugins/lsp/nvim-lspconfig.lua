return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		-- 1) 新APIが使えるならそれを使う（警告は出ない）
		local new = vim.lsp and vim.lsp.config

		local function setup(server, opts)
			opts = opts or {}
			if new and new[server] and type(new[server].setup) == "function" then
				return new[server].setup(opts) -- 新API
			end
			-- 2) 新APIが無い環境だけ旧APIにフォールバック
			local ok, old = pcall(require, "lspconfig")
			if ok and old[server] and type(old[server].setup) == "function" then
				return old[server].setup(opts) -- 旧API（※警告が出るのはこのときだけ）
			end
			vim.notify(("LSP server '%s' not available"):format(server), vim.log.levels.WARN)
		end

		-- servers
		setup("clangd")
		setup("lua_ls", {
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					workspace = { checkThirdParty = false },
				},
			},
		})
		setup("pyright")
		setup("jsonls")
		setup("html")
		setup("cssls")
		setup("gopls")
		setup("bashls")
		setup("yamlls")
		setup("rust_analyzer")
	end,
}
