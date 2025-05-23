return {
	"rcarriga/nvim-notify",
	config = function()
		require("notify").setup({
			stages = "fade",
			timeout = 3000,
			top_down = false,
		})
		local telescope = require("telescope")
		telescope.load_extension("notify")

		vim.keymap.set("n", "<leader>fn", function()
			telescope.extensions.notify.notify()
		end)
		vim.notify = require("notify")
	end,
}
