-- Indentation
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- Line numbers and scrolling
vim.opt.number = true
vim.api.nvim_set_option("scrolloff", 4)

-- Open new splits to the right and below
vim.o.splitright = true
vim.o.splitbelow = true

-- Use the system clipboard
vim.opt.clipboard = "unnamedplus"

-- Hide end-of-buffer markers
vim.opt.fillchars:append({ eob = " " })

-- Command line, status line, and tab line
vim.opt.cmdheight = 0
vim.opt.laststatus = 3
vim.opt.showtabline = 0

-- Keep the sign column visible
vim.opt.signcolumn = "yes"
