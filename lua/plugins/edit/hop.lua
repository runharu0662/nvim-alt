return {
	"smoka7/hop.nvim",
	event = "BufRead",
	version = "*",
	opts = {
		multi_windows = false,
	},
	keys = {
		-- Explicit jump commands; preserve native f / F / t / T.
		{ "<leader>hw", "<cmd>HopWord<CR>", mode = "n", desc = "Hop Word" },
		{ "<leader>hl", "<cmd>HopLine<CR>", mode = "n", desc = "Hop Line" },
		{ "<leader>hc", "<cmd>HopChar1<CR>", mode = "n", desc = "Hop Char" },
		{ "<leader>hp", "<cmd>HopPattern<CR>", mode = "n", desc = "Hop Pattern" },
	},
}
