return {
	"goolord/alpha-nvim",
	dependencies = {
		"echasnovski/mini.icons",
		"nvim-lua/plenary.nvim",
	},
	opts = function()
		local dashboard = require("alpha.themes.dashboard")
		dashboard.section.header.val = require("ascii").art.text.neovim.sharp
		return dashboard.opts
	end,
}
