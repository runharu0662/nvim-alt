return {
	"smoka7/hop.nvim",
	event = "BufRead",
	version = "*",
	opts = {
		multi_windows = false,
	},
	keys = {
		{ "<space><space>", "", mode = "n", desc = "Hop" },

		-- <leader><leader> 以下のマッピング
		{ "<leader><leader>w", "<cmd>HopWord<CR>", mode = "n", desc = "Hop Word" },
		{ "<leader><leader>l", "<cmd>HopLine<CR>", mode = "n", desc = "Hop Line" },
		{ "<leader><leader>c", "<cmd>HopChar1<CR>", mode = "n", desc = "Hop Char" },
		{ "<leader><leader>p", "<cmd>HopPattern<CR>", mode = "n", desc = "Hop Pattern" },
		{ "f", "<cmd>HopChar1CurrentLineAC<CR>", mode = { "n", "v", "o" }, desc = "Hop Char in Line (After Cursor)" },
		{ "F", "<cmd>HopChar1CurrentLineBC<CR>", mode = { "n", "v", "o" }, desc = "Hop Char in Line (Before Cursor)" },
		{
			"t",
			"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<CR>",
			mode = { "n", "v", "o" },
			desc = "Hop Before Char in Line (After Cursor)",
		},
		{
			"T",
			"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<CR>",
			mode = { "n", "v", "o" },
			desc = "Hop After Char in Line (Before Cursor)",
		},
	},
}
