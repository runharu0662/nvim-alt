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
			sections = {
				lualine_c = {
					{
						"diagnostics",
						sources = { "nvim_diagnostic", "nvim_lsp" },
						sections = { "error", "warn", "info", "hint" },
						symbols = { error = " ", warn = " ", info = " ", hint = "" },
					},
				},
			},
		})
	end,
}
