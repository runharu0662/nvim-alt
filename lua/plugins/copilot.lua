return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			suggestion = {
				enabled = true,
				auto_trigger = false, -- trueにすると自動で候補が出る
			},
			panel = {
				enabled = true,
			},
			filetypes = {
				["*"] = true, -- すべてのファイルタイプで有効
			},
		})

		-- Copilot suggestion 操作用キーマップ
		local s = require("copilot.suggestion")

		-- 候補をすべて受け入れる
		vim.keymap.set("i", "<C-l>", function()
			s.accept()
		end, { desc = "Copilot: Accept" })

		-- 単語だけ受け入れる
		vim.keymap.set("i", "<C-;>", function()
			s.accept_word()
		end, { desc = "Copilot: Accept Word" })

		-- 行だけ受け入れる
		vim.keymap.set("i", "<C-'>", function()
			s.accept_line()
		end, { desc = "Copilot: Accept Line" })

		-- 複数候補がある場合の切り替え
		vim.keymap.set("i", "<C-]>", function()
			s.next()
		end, { desc = "Copilot: Next Suggestion" })

		vim.keymap.set("i", "<C-[>", function()
			s.prev()
		end, { desc = "Copilot: Previous Suggestion" })

		-- 候補を閉じる
		vim.keymap.set("i", "<C-x>", function()
			s.dismiss()
		end, { desc = "Copilot: Dismiss" })
	end,
}
