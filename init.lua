require("config.lazy")
require("mappings")
require("options")
vim.cmd([[colorscheme tokyonight-storm]])


-- ベース
local hl = vim.api.nvim_set_hl
local none = { bg = "none" }

-- 基本UI
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

-- Cokeline
hl(0, "CokelineTab", none)
hl(0, "CokelineTabSelected", none)
hl(0, "CokelineBackground", none)
hl(0, "CokelineBufferVisible", none)
hl(0, "CokelineBufferSelected", none)
hl(0, "CokelineBufferHidden", none)

-- nvim-ufo 関連
hl(0, "Folded", none)
hl(0, "UfoFoldedBg", none)
hl(0, "UfoFoldedFg", { fg = "#888888", bg = "none" })  -- フォント色だけ薄く指定して透過
hl(0, "UfoPreviewSbar", none)
hl(0, "UfoPreviewThumb", none)
hl(0, "UfoPreviewWinBar", none)
hl(0, "UfoPreviewCursorLine", none)
hl(0, "UfoPreviewNormal", none)
hl(0, "UfoPreviewBorder", none)

-- 透明が必要そうなもの
hl(0, "VertSplit", none)
hl(0, "TabLineFill", none)
hl(0, "TabLine", none)
hl(0, "TabLineSel", none)

