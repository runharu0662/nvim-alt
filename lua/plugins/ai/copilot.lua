-- ~/.config/nvim-alt/lua/plugins/ai/copilot.lua
return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot", -- :Copilot で遅延ロード
	event = "InsertEnter", -- 挿入モードで自動ロード
	opts = {
		suggestion = {
			enabled = true,
			auto_trigger = true,
			keymap = {
				accept = "<C-l>",
				accept_word = "<C-;>",
				accept_line = "<C-'>",
				dismiss = "<C-x>",
			},
		},
		panel = { enabled = false },
		filetypes = { ["*"] = true },
	},
}
