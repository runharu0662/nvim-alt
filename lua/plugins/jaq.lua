return {
	"is0n/jaq-nvim",
	config = function()
		require("jaq-nvim").setup({
			cmds = {
				-- C++20 に対応したコンパイル & stdin.txt を標準入力に
				cpp = "g++ -std=c++20 % -o a.out && ./a.out < stdin.txt",
			},

			behavior = {
				-- Default type
				default = "float",

				-- Start in insert mode
				startinsert = false,

				-- Use `wincmd p` on startup
				wincmd = false,

				-- Auto-save files
				autosave = true,
			},

			ui = {
				float = {
					-- See ':h nvim_open_win'
					border = "rounded",

					-- See ':h winhl'
					winhl = "Normal",
					borderhl = "FloatBorder",

					-- See ':h winblend'
					winblend = 0,

					-- Num from `0-1` for measurements
					height = 0.8,
					width = 0.8,
					x = 0.5,
					y = 0.5,
				},

				terminal = {
					-- Window position
					position = "bot",

					-- Window size
					size = 10,

					-- Disable line numbers
					line_no = false,
				},

				quickfix = {
					-- Window position
					position = "bot",

					-- Window size
					size = 10,
				},
			},
		})
	end,
}
