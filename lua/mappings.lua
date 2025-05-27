-- rename function
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol (LSP)" })

-- change f to $
vim.keymap.set("n", "f", "$", { noremap = true })

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

-- make_stdin
vim.keymap.set("n", "<Space>js", ":wa <bar> :RunInput<CR>", { noremap = true, silent = true, desc = "cpp RunInput" })
vim.keymap.set("n", "<Space>jt", ":InsTemp<CR>", { noremap = true, silent = true, desc = "Insert cpp Template" })

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
