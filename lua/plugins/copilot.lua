return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			suggestion = {
				enabled = true,
				auto_trigger = true, -- 自動ポップ無効
				keymap = {
					accept = "<C-l>", -- 候補を確定
					next = "<M-n>", -- 次の候補
					prev = "<M-p>", -- 前の候補
					dismiss = "<C-]>",
				},
			},
			panel = { enabled = true },
			filetypes = { ["*"] = true },
		})
	end,
}
