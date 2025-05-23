-- lua/plugins/lualine.lua
return {
	"hoob3rt/lualine.nvim",
	requires = { "kyazdani42/nvim-web-devicons", opt = true },
	config = function()
		require("lualine").setup({
			options = {
				theme = "dracula",
				globalstatus = true,
			},
	end,
}
