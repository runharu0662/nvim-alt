local M = {}

M.servers = {
	gopls = { command = "gopls" },
	ts_ls = { command = "typescript-language-server", args = { "--stdio" } },
	eslint = { command = "vscode-eslint-language-server", args = { "--stdio" } },
	html = { command = "vscode-html-language-server", args = { "--stdio" } },
	cssls = { command = "vscode-css-language-server", args = { "--stdio" } },
	jsonls = { command = "vscode-json-language-server", args = { "--stdio" } },
	yamlls = { command = "yaml-language-server", args = { "--stdio" } },
	terraformls = { command = "terraform-ls", args = { "serve" } },
	tflint = { command = "tflint", args = { "--langserver" } },
	dockerls = { command = "docker-langserver", args = { "--stdio" } },
	bashls = { command = "bash-language-server", args = { "start" } },
	lua_ls = { command = "lua-language-server" },
}

-- Prefer the project's Node tools, then Mason / the shell PATH. Never install on open.
function M.executable(command, path)
	local dir = path or vim.fn.getcwd()
	if vim.fn.isdirectory(dir) == 0 then
		dir = vim.fs.dirname(dir)
	end
	while dir do
		local candidate = dir .. "/node_modules/.bin/" .. command
		if vim.fn.executable(candidate) == 1 then
			return candidate
		end
		local parent = vim.fs.dirname(dir)
		if parent == dir then
			break
		end
		dir = parent
	end
	if vim.fn.executable(command) == 1 then
		return vim.fn.exepath(command)
	end
end

function M.setup_lsp()
	vim.lsp.config("*", { capabilities = require("cmp_nvim_lsp").default_capabilities() })
	vim.lsp.config("gopls", {
		filetypes = { "go", "gomod", "gosum", "gowork", "gotmpl" },
		settings = { gopls = { staticcheck = true } },
	})
	vim.lsp.config("eslint", { settings = { format = false } })
	vim.lsp.config("lua_ls", {
		settings = { Lua = { diagnostics = { globals = { "vim" } }, workspace = { checkThirdParty = false } } },
	})
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("web_lsp_navigation", { clear = true }),
		callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if not client or client.name == "null-ls" then
				return
			end
			for key, fn in pairs({ gd = vim.lsp.buf.definition, gr = vim.lsp.buf.references }) do
				if vim.fn.maparg(key, "n") == "" then
					vim.keymap.set(
						"n",
						key,
						fn,
						{ buffer = args.buf, desc = key == "gd" and "LSP definition" or "LSP references" }
					)
				end
			end
			if client.name == "gopls" or client.name == "ts_ls" then
				vim.api.nvim_buf_create_user_command(args.buf, "OrganizeImports", function()
					vim.lsp.buf.code_action({
						context = { only = { "source.organizeImports" }, diagnostics = {} },
						apply = true,
					})
				end, { desc = "Organize imports through LSP", force = true })
			end
		end,
	})
	for name, spec in pairs(M.servers) do
		local base = vim.lsp.config[name]
		assert(base, "Missing lspconfig configuration: " .. name)
		vim.lsp.config(name, {
			cmd = function(dispatchers, config)
				local command = assert(M.executable(spec.command, config.root_dir), spec.command .. " is unavailable")
				return vim.lsp.rpc.start(vim.list_extend({ command }, spec.args or {}), dispatchers)
			end,
			root_dir = function(bufnr, on_dir)
				local path = vim.api.nvim_buf_get_name(bufnr)
				if not M.executable(spec.command, path ~= "" and path or nil) then
					return
				end
				if type(base.root_dir) == "function" then
					base.root_dir(bufnr, on_dir)
				else
					local root = vim.fs.root(bufnr, base.root_markers or { ".git" })
					if root or not base.workspace_required then
						on_dir(root or vim.fs.dirname(path) or vim.fn.getcwd())
					end
				end
			end,
		})
		vim.lsp.enable(name)
	end
end

local formatters = {
	go = { "goimports", "gofmt" },
	terraform = { "terraform" },
	["terraform-vars"] = { "terraform" },
	javascript = { "prettier" },
	javascriptreact = { "prettier" },
	typescript = { "prettier" },
	typescriptreact = { "prettier" },
	html = { "prettier" },
	css = { "prettier" },
	scss = { "prettier" },
	json = { "prettier" },
	jsonc = { "prettier" },
	yaml = { "prettier" },
	markdown = { "prettier" },
	sh = { "shfmt" },
	lua = { "stylua" },
}

function M.format(opts)
	opts = opts or {}
	local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients({ bufnr = bufnr, method = "textDocument/formatting" })
	local chosen
	for _, command in ipairs(formatters[vim.bo[bufnr].filetype] or {}) do
		if M.executable(command, vim.api.nvim_buf_get_name(bufnr)) then
			for _, client in ipairs(clients) do
				if client.name == "null-ls" then
					chosen = client
				end
			end
			if chosen then
				break
			end
		end
	end
	if not chosen then
		for _, client in ipairs(clients) do
			if client.name ~= "null-ls" and client.name ~= "eslint" then
				if not chosen or client.id < chosen.id then
					chosen = client
				end
			end
		end
	end
	if not chosen then
		if not opts.quiet then
			vim.notify("No formatter available for this buffer", vim.log.levels.INFO)
		end
		return
	end
	vim.lsp.buf.format({ bufnr = bufnr, id = chosen.id, async = opts.async or false, timeout_ms = 3000 })
end

function M.setup_formatting()
	local group = vim.api.nvim_create_augroup("web_formatting", { clear = true })
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = group,
		callback = function(args)
			-- Keep article whitespace intact on save; explicit <leader>n still formats Markdown.
			if vim.bo[args.buf].filetype ~= "markdown" and vim.bo[args.buf].buftype == "" then
				M.format({ bufnr = args.buf, quiet = true })
			end
		end,
	})
end

return M
