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

-- quickrun
vim.keymap.set(
	"n",
	"<Space>rr",
	":wa <bar> :QuickRun <stdin.txt<CR>",
	{ noremap = true, silent = true, desc = "cpp QuickRun" }
)
