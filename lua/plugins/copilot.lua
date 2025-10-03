return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			suggestion = {
				enabled = true,
				auto_trigger = false, -- 自動ポップ無効
				keymap = {
					accept = "<C-l>", -- 候補を確定
					accept_word = "<M-;>", -- 単語だけ確定
					accept_line = "<M-'>", -- 行だけ確定
					next = "<M-n>", -- 次の候補
					prev = "<M-p>", -- 前の候補
					dismiss = "<C-x>", -- 候補を閉じる
				},
			},
			panel = { enabled = true },
			filetypes = { ["*"] = true },
		})

		-- 手動トリガー
		vim.keymap.set("i", "<M-.>", function()
			require("copilot.suggestion").trigger()
		end, { desc = "Copilot: Trigger suggestion" })
	end,
}
