-- this is for japanese input
return {
	{
		"vim-skk/skkeleton",
		dependencies = { "vim-denops/denops.vim" },

		init = function()
			vim.keymap.set({ "i", "c" }, "<C-j>", "<Plug>(skkeleton-toggle)", { noremap = false })
		end,

		config = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "DenopsPluginPost:skkeleton",
				callback = function()
					vim.fn["skkeleton#initialize"]()
					vim.fn["skkeleton#config"]({
						globalDictionaries = {
							vim.fn.expand("~/.skk/SKK-JISYO.L"),
						},
						eggLikeNewline = true,
					})

					vim.fn["skkeleton#register_keymap"]("henkan", "<C-n>", "henkanForward")
					vim.fn["skkeleton#register_keymap"]("henkan", "<C-p>", "henkanBackward")
					vim.fn["skkeleton#register_keymap"]("henkan", "<C-y>", "kakutei")
					vim.fn["skkeleton#register_keymap"]("henkan", "<C-e>", "cancel")
				end,
			})
		end,
	},

	{
		"delphinus/skkeleton_indicator.nvim",
		config = function()
			local bg = "#1a1b26" -- tokyonight-storm
			local fg = "#7aa2f7" -- blue

			vim.api.nvim_set_hl(0, "SkkeletonIndicatorEiji", { fg = fg, bg = bg, bold = false })
			vim.api.nvim_set_hl(0, "SkkeletonIndicatorHira", { fg = "#1a1b26", bg = "#9ece6a", bold = false })
			vim.api.nvim_set_hl(0, "SkkeletonIndicatorKata", { fg = "#1a1b26", bg = "#e0af68", bold = false })
			vim.api.nvim_set_hl(0, "SkkeletonIndicatorAbbrev", { fg = "#1a1b26", bg = "#f7768e", bold = false })

			require("skkeleton_indicator").setup({
				eijiText = "A",
				hiraText = "あ",
				kataText = "ア",
				border = nil,
				row = 1,
				col = 0,
				fadeOutMs = 0,
				alwaysShown = false,
				zindex = 999,
			})
		end,
	},
}
