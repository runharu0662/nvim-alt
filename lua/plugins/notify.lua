return {
	"rcarriga/nvim-notify",
	config = function()
		require("notify").setup({
			stages = "fade",
			timeout = 3000,
			top_down = false,
		})
		vim.notify = require("notify")
	end,
}
