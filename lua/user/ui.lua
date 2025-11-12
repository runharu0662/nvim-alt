-- diagnostic icons
local icons = require("user.icons")

local signs = {
	Error = icons.error_icon,
	Warn = icons.warn_icon,
	Hint = icons.hint_icon,
	Info = icons.info_icon,
}

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

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

-- lspsaga style
vim.api.nvim_set_hl(0, "SagaNormal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "SagaBorder", { bg = "NONE", fg = "#3b4261" }) -- 枠線の色をtokyonightに合わせる
vim.api.nvim_set_hl(0, "WinBar", { bg = "NONE" })
vim.api.nvim_set_hl(0, "WinBarNC", { bg = "NONE" })
