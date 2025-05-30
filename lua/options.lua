-- expandtab
vim.opt.expandtab = true
-- tabstop
vim.opt.tabstop = 4
-- softtabstop
vim.opt.softtabstop = 4
-- shiftwidth
vim.opt.shiftwidth = 4
-- number
vim.opt.number = true

-- new split direction
vim.o.splitright = true
vim.o.splitbelow = true

vim.api.nvim_set_option("scrolloff", 4)

-- clipboard
vim.opt.clipboard = "unnamedplus"

-- grobalにlualine
vim.o.laststatus = 3

-- signcolumn lightbulb
vim.o.signcolumn = "yes"

vim.opt.laststatus = 3
vim.opt.cmdheight = 0
vim.opt.fillchars:append({ eob = " " })

require("noice").setup({
    cmdline = {
        view = "cmdline_popup",
    },
})
