require("config.lazy")
require("mappings")
require("options")
vim.cmd([[colorscheme tokyonight-storm]])
require("user.ui")

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    vim.o.laststatus = 3
  end,
})

