--copilot
vim.api.nvim_create_user_command("CopilotToggle", function()
	local copilot = require("copilot.suggestion")
	if copilot.is_visible() then
		copilot.dismiss()
		print("Copilot: suggestion dismissed")
	elseif require("copilot.client").is_disabled() then
		vim.cmd("Copilot enable")
		print("Copilot: enabled")
	else
		vim.cmd("Copilot disable")
		print("Copilot: disabled")
	end
end, {})

vim.keymap.set("n", "<leader>lt", "<cmd>CopilotToggle<CR>", { desc = "Toggle Copilot" })

-- split right
vim.keymap.set("n", "<leader>v", ":vsplit<CR>", {
	noremap = true,
	silent = true,
	desc = "Split window vertically (right)",
})

-- lspsaga code_action
vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { desc = "Code Action" })

-- Add notify setting
local telescope = require("telescope")
telescope.load_extension("notify")
vim.keymap.set("n", "<leader>fn", function()
	telescope.extensions.notify.notify()
end, {
	desc = "Find Nofify Logs",
}) -- rename function

vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol (LSP)" })

-- change f and F to move to the start and end of the line
vim.keymap.set({ "n", "v" }, "F", "$", { noremap = true })
vim.keymap.set({ "n", "v" }, "f", "0", { noremap = true })

-- move between windows
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to below window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to above window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- neotree
vim.keymap.set("n", "<space>e", "<cmd>Neotree toggle<CR>", { desc = "Neo-tree toggle" })

-- telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

-- nole-ls
vim.keymap.set("n", "<leader>n", function()
	vim.lsp.buf.format({
		timeout_ms = 200,
		async = true,
	})
end, { desc = "Format with null-ls" })

-- close buffer
vim.keymap.set("n", "<leader>bc", "<cmd>bdelete<CR>", { desc = "Close current buffer" })

-- diffview
vim.keymap.set(
	"n",
	"<leader>ld",
	"<cmd>DiffviewOpen HEAD~1<CR>",
	{ noremap = true, silent = true, desc = "Open diffview with HEAD~1" }
)
vim.keymap.set(
	"n",
	"<leader>lf",
	"<cmd>DiffviewFileHistory %<CR>",
	{ noremap = true, silent = true, desc = "Open diffview file history" }
)

-- toggleterm
local Terminal = require("toggleterm.terminal").Terminal

-- Float terminal
local float_term = Terminal:new({
	direction = "float",
	float_opts = {
		border = "rounded",
	},
	hidden = true,
})
vim.keymap.set("n", "<leader>tf", function()
	float_term:toggle()
end, { desc = "Toggle float terminal" })

-- Vertical split terminal
local vert_term = Terminal:new({
	direction = "vertical",
	size = 60,
	hidden = true,
})
vim.keymap.set("n", "<leader>tv", function()
	vert_term:toggle()
end, { desc = "Toggle vertical terminal" })

-- Horizontal split terminal
local hori_term = Terminal:new({
	direction = "horizontal",
	size = 15,
	hidden = true,
})
vim.keymap.set("n", "<leader>th", function()
	hori_term:toggle()
end, { desc = "Toggle horizontal terminal" })

-- make_stdin
vim.keymap.set("n", "<Space>js", ":wa <bar> :RunInput<CR>", { noremap = true, silent = true, desc = "cpp RunInput" })
vim.keymap.set("n", "<Space>jt", ":InsTemp<CR>", { noremap = true, silent = true, desc = "Insert cpp Template" })

-- run_cpp
local Terminal = require("toggleterm.terminal").Terminal

local function run_cpp()
	vim.cmd("wa") -- Save all files before running
	local file = vim.fn.expand("%")

	local cmd = "/opt/homebrew/bin/gtime -f '[Time] %es\n\n\n' g++ -std=c++20 "
		.. file
		.. " -o a.out && ./a.out < stdin.txt"

	local cpp_term = Terminal:new({
		cmd = cmd,
		direction = "float",
		close_on_exit = false,
	})

	cpp_term:toggle()
end

vim.keymap.set("n", "<leader>jj", run_cpp, { desc = "Run C++ with stdin and time", silent = true })

vim.keymap.set("n", "<leader>pi", ":PasteImage<CR>", { desc = "Paste dropped image as Markdown" })
