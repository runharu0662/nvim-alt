require("config.lazy")
require("mappings")
require("func.functions")
require("options")
vim.cmd([[colorscheme tokyonight-storm]])
require("user.ui")

-- change comment color
vim.api.nvim_set_hl(0, "Comment", { fg = "#9ec6ff", italic = true })
