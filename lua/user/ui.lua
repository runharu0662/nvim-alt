local icons = require("user.icons")

local signs = { Error = icons.error_icon, Warn = icons.warn_icon, Hint = icons.hint_icon, Info = icons.info_icon }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local icons = require("user.icons")

vim.diagnostic.config({
	virtual_text = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = icons.error_icon,
			[vim.diagnostic.severity.WARN] = icons.warn_icon,
			[vim.diagnostic.severity.HINT] = icons.hint_icon,
			[vim.diagnostic.severity.INFO] = icons.info_icon,
		},
	},
})

local hl = vim.api.nvim_set_hl
local none = { bg = "none" }

-- basic UI
hl(0, "Normal", none)
hl(0, "NormalNC", none)
hl(0, "NormalFloat", none)
hl(0, "FloatBorder", none)
hl(0, "SignColumn", none)
hl(0, "EndOfBuffer", none)
hl(0, "StatusLine", none)
hl(0, "WinSeparator", none)

-- Telescope
hl(0, "TelescopeNormal", none)
hl(0, "TelescopeBorder", none)
hl(0, "TelescopePromptNormal", none)
hl(0, "TelescopePromptBorder", none)
hl(0, "TelescopeResultsNormal", none)
hl(0, "TelescopeResultsBorder", none)
hl(0, "TelescopePreviewNormal", none)
hl(0, "TelescopePreviewBorder", none)

-- Neo-tree
hl(0, "NeoTreeNormal", none)
hl(0, "NeoTreeNormalNC", none)
hl(0, "NeoTreeEndOfBuffer", none)
hl(0, "NeoTreeFloatBorder", none)
hl(0, "NeoTreeWinSeparator", none)

hl(0, "VertSplit", none)
hl(0, "TabLineFill", none)
hl(0, "TabLine", none)
hl(0, "TabLineSel", none)

hl(0, "WinBar", none)
hl(0, "WinBarNC", none)

hl(0, "SagaWinbar", none)

local none = { bg = "none" }

vim.api.nvim_set_hl(0, "Normal", none)
vim.api.nvim_set_hl(0, "NormalNC", none)
vim.api.nvim_set_hl(0, "TermNormal", none) -- for splitting terminal
vim.api.nvim_set_hl(0, "TermNormalNC", none)
vim.api.nvim_set_hl(0, "EndOfBuffer", none)

-- change comment color
vim.api.nvim_set_hl(0, "Comment", { fg = "#9ec6ff", italic = true })
