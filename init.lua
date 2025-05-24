require("config.lazy")
require("mappings")
require("options")
require("func.functions")
vim.cmd([[colorscheme tokyonight-storm]])
require("user.ui")

-- grobalにlualine
vim.o.laststatus = 3

-- "~"を非表示
vim.opt.fillchars:append({ eob = " " })
