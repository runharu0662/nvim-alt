require("config.lazy")
require("mappings")
require("func.functions")
require("options")
vim.cmd([[colorscheme tokyonight-storm]])
require("user.ui")

-- disable command line
vim.opt.cmdheight = 0
vim.opt.laststatus = 3
