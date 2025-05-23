require("config.lazy")
require("mappings")
vim.cmd([[colorscheme tokyonight-storm]])
require("user.ui")

require("options")
-- grobalにlualine
vim.o.laststatus = 3

