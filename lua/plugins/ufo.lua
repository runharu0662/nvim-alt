return {
	"kevinhwang91/nvim-ufo",
	dependencies = { "kevinhwang91/promise-async" },
	config = function()
		require("ufo").setup()
		vim.foldenable = false
		vim.o.foldlevel = 99
		vim.o.foldcolumn = "1"
	end,
}
