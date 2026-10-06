-- Run in a disposable state directory with existing plugins; no downloads or installs.
local root = vim.fn.getcwd()
local plugin_root = assert(vim.env.NVIM_TEST_PLUGINS, "Set NVIM_TEST_PLUGINS to the existing lazy plugin directory")
vim.opt.rtp:prepend(root)
vim.opt.rtp:append(root .. "/after")
for _, dir in ipairs(vim.fn.glob(plugin_root .. "/*", false, true)) do
	vim.opt.rtp:append(dir)
end
vim.g.mapleader = " "
require("mason").setup({ install_root_dir = vim.fn.stdpath("data") .. "/mason" })
dofile("lua/plugins/edit/cmp.lua").config()
dofile("lua/plugins/lsp/nvim-lspconfig.lua").config()
dofile("lua/plugins/lsp/mason-null-ls.lua").config()
require("telescope").setup(dofile("lua/plugins/tools/telescope.lua").opts)
require("toggleterm").setup({})
dofile("lua/mappings.lua")
dofile("lua/func/functions.lua")

local tools = require("config.development")
for name in pairs(tools.servers) do
	assert(vim.lsp.config[name], name)
end
for _, file in ipairs(vim.fn.glob("lua/**/*.lua", false, true)) do assert(loadfile(file), file) end
for _, file in ipairs(vim.fn.glob("after/**/*.lua", false, true)) do assert(loadfile(file), file) end
local parsers = require("nvim-treesitter.parsers").get_parser_configs()
local ts_opts
local configs = require("nvim-treesitter.configs")
local old_setup = configs.setup
configs.setup = function(opts) ts_opts = opts end
dofile("lua/plugins/edit/treesitter.lua").config()
configs.setup = old_setup
for _, name in ipairs(ts_opts.ensure_installed) do assert(parsers[name], "Unknown parser " .. name) end

for _, key in ipairs({" lt", " v", " ca", " rn", " e", " ff", " fg", " fb", " fh", " n", " bc", " tf", " tv", " th", " pi", " pc", " po"}) do
	assert(vim.fn.maparg(key, "n") ~= "", "Missing existing mapping: " .. key)
end
local baseline = vim.fn.system({ "git", "show", "simple:lua/mappings.lua" })
assert(vim.v.shell_error == 0, "Cannot read simple mapping baseline")
assert(loadstring(baseline))()
local before = {}
for _, mode in ipairs({ "n", "v", "i", "c" }) do before[mode] = vim.api.nvim_get_keymap(mode) end
dofile("lua/mappings.lua")
for mode, maps in pairs(before) do
	for _, map in ipairs(maps) do
		local current
		for _, candidate in ipairs(vim.api.nvim_get_keymap(mode)) do
			if candidate.lhs == map.lhs then current = candidate; break end
		end
		assert(current, "Removed mapping: " .. map.lhs)
		assert(current.rhs == map.rhs and current.desc == map.desc, "Changed mapping: " .. map.lhs)
	end
end
assert(vim.fn.exists(":RunInput") == 0 and vim.fn.exists(":InsTemp") == 0)
assert(vim.fn.exists(":CreateMdLink") == 2 and vim.fn.exists(":PasteClipboardImage") == 2)

for name in pairs(tools.servers) do vim.lsp.enable(name, false) end

-- Verify one formatting client, provider priority, absent-tool fallback, and no ESLint formatting.
local old_clients, old_format, old_executable = vim.lsp.get_clients, vim.lsp.buf.format, tools.executable
local formatted, installed = nil, {}
vim.lsp.get_clients = function() return {{id=1,name="gopls"},{id=2,name="null-ls"},{id=3,name="eslint"}} end
vim.lsp.buf.format = function(opts) formatted = opts end
tools.executable = function(command) return installed[command] and "/test/" .. command or nil end
vim.bo.filetype = "go"
tools.format()
assert(formatted.id == 1)
installed.goimports = true
tools.format()
assert(formatted.id == 2)
vim.bo.filetype = "typescript"
installed = {prettier=true}
tools.format({async=true})
assert(formatted.id == 2 and formatted.async)
vim.lsp.get_clients = function() return {{id=3,name="eslint"}} end
formatted = nil
tools.format({quiet=true})
assert(formatted == nil)
local called = false
vim.lsp.config.gopls.root_dir(0, function() called=true end)
assert(not called, "Missing server should not start")
vim.lsp.get_clients, vim.lsp.buf.format, tools.executable = old_clients, old_format, old_executable

vim.bo.filetype = "markdown"
dofile("after/ftplugin/markdown.lua")
assert(vim.wo.wrap and vim.wo.linebreak and vim.bo.textwidth == 0)
assert(not require("cmp").get_config().enabled())
local writes = vim.api.nvim_get_autocmds({group="web_formatting",event="BufWritePre"})
assert(#writes == 1)
local old_helper = tools.format
called = false
tools.format = function() called=true end
writes[1].callback({buf=vim.api.nvim_get_current_buf()})
assert(not called, "Markdown must not be autoformatted")
tools.format = old_helper
local lock = vim.json.decode(table.concat(vim.fn.readfile("lazy-lock.json"), "\n"))
assert(lock.skkeleton and lock["denops.vim"] and lock["none-ls.nvim"])
-- Exercise the real none-ls -> gofmt fallback when Go is available on this machine.
if vim.fn.executable("gofmt") == 1 then
	local fixture = vim.fn.tempname() .. "-web-go"
	vim.fn.mkdir(fixture, "p")
	vim.fn.writefile({ "package main", 'func main(){println("ok")}' }, fixture .. "/main.go")
	vim.cmd("edit " .. vim.fn.fnameescape(fixture .. "/main.go"))
	vim.bo.filetype = "go"
	assert(vim.wait(3000, function()
		return #vim.lsp.get_clients({bufnr=0,method="textDocument/formatting"}) > 0
	end), "none-ls did not attach to Go fixture")
	tools.format()
	assert(table.concat(vim.api.nvim_buf_get_lines(0,0,-1,false), "\n"):find('func main%(%) {'), "Real Go formatting failed")
	vim.bo.modified = false
	print("PASS: real Go formatting through none-ls")
end
print("PASS: real plugin setup, servers/parsers, existing mappings, format selection and Markdown preservation")
