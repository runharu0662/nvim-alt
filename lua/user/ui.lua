-- diagnostic icons
local icons = require("user.icons")

vim.diagnostic.config({
	virtual_text = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = icons.error_icon,
			[vim.diagnostic.severity.WARN] = icons.warn_icon,
			[vim.diagnostic.severity.HINT] = icons.hint_icon,
			[vim.diagnostic.severity.INFO] = icons.info_icon,
		},
	},
})

-- comment style
vim.api.nvim_set_hl(0, "Comment", { fg = "#9ec6ff", italic = true })
