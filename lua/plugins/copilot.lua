return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			suggestion = {
				enabled = true,
				auto_trigger = false, -- 自動ポップ無効（手動トリガで使う）
				keymap = {
					accept = "<C-l>", -- 候補を確定
					accept_word = "<M-;>", -- 単語だけ確定 (Option+;)
					accept_line = "<M-'>", -- 行だけ確定   (Option+')
					next = "<M-n>", -- 次の候補     (Option+n)
					prev = "<M-p>", -- 前の候補     (Option+p)
					dismiss = "<C-x>", -- 候補を閉じる
				},

			panel = {
				enabled = true,
			},

			filetypes = {
				["*"] = true,
			},
			panel = { enabled = true },
			filetypes = { ["*"] = true },
		})

		-- 手動トリガー（候補を出す）
		vim.keymap.set("i", "<M-.>", function()
			require("copilot.suggestion").trigger()
		end, { desc = "Copilot: Trigger suggestion" })
	end,
}
