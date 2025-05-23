require("config.lazy")
require("mappings")
require("options")
vim.cmd([[colorscheme tokyonight-storm]])
require("user.ui")

-- grobalにlualine
vim.o.laststatus = 3

vim.api.nvim_create_autocmd("FileType", {
  pattern = "neo-tree",
  callback = function()
    vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "NONE", bg = "NONE" })
  end,
})

