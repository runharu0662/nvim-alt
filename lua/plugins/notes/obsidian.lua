return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim", -- optional but recommended
		"hrsh7th/nvim-cmp", -- optional
		"nvim-treesitter/nvim-treesitter", -- optional
		{ "oflisback/obsidian-bridge.nvim", opts = { scroll_sync = true } },
	},
	opts = {
		workspaces = {
			{
				name = "vault1",
				path = vim.fn.expand("~/Documents/Latest_Documents/Obsidian_Vaults/obsidian-vault1/Obsidian_Vault1"),
			},
		},
		new_notes_location = "current_dir",
		completion = { nvim_cmp = true },
		picker = {
			name = "telescope.nvim",
		},
		ui = {
			enable = true,
			checkboxes = {
				[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
				["x"] = { char = "", hl_group = "ObsidianDone" },
			},
			bullets = { char = "•", hl_group = "ObsidianBullet" },
		},
		attachments = {
			img_folder = "screen_shots", -- 任意の画像フォルダ（相対 or 絶対）
		},
	},
}
