return {
	"goolord/alpha-nvim",
	dependencies = {
		-- ここに 'nvim-terminal-ascii' を追加します
		"norcalli/nvim-terminal-ascii",
		"echasnovski/mini.icons",
		"nvim-lua/plenary.nvim",
	},
	opts = function()
		local dashboard = require("alpha.themes.dashboard")
		-- 修正不要：この require("ascii") が nvim-terminal-ascii の機能を使用します
		dashboard.section.header.val = require("ascii").art.text.neovim.sharp
		return dashboard.opts
	end,
}
