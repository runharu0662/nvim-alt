-- ~/.config/nvim-alt/lua/plugins/ai/copilotchat.lua
return {
	"CopilotC-Nvim/CopilotChat.nvim",
	branch = "main",
	dependencies = {
		"zbirenbaum/copilot.lua",
		"nvim-lua/plenary.nvim",
	},
	build = "make tiktoken", -- mac/Linux
	opts = {
		debug = true,
		show_help = "yes",
	},

	config = function(_, opts)
		local chat = require("CopilotChat")
		local select = require("CopilotChat.select")

		chat.setup(vim.tbl_extend("force", opts, {
			prompts = {
				Explain = {
					prompt = "/COPILOT_EXPLAIN コードを日本語で説明してください",
					mapping = "<leader>ce",
					description = "コードの説明",
				},
				Review = {
					prompt = "/COPILOT_REVIEW コードを日本語でレビューしてください。",
					mapping = "<leader>cr",
					description = "レビュー",
				},
				Fix = {
					prompt = "/COPILOT_FIX バグを修正したコードを提示。説明は日本語で。",
					mapping = "<leader>cf",
					description = "修正",
				},
				Optimize = {
					prompt = "/COPILOT_REFACTOR 最適化。説明は日本語で。",
					mapping = "<leader>co",
					description = "最適化",
				},
				Docs = {
					prompt = "/COPILOT_GENERATE 日本語ドキュメントコメントを生成。",
					mapping = "<leader>cD",
					description = "ドキュメント生成",
				},
				Tests = {
					prompt = "/COPILOT_TESTS 詳細なユニットテストを作成。日本語説明。",
					mapping = "<leader>ct",
					description = "テスト生成",
				},
				FixDiagnostic = {
					prompt = "診断結果に従い修正。日本語で説明。",
					mapping = "<leader>cd",
					description = "診断→修正",
					selection = select.diagnostics,
				},
				Commit = {
					prompt = "差分に対するコミットメッセージを日本語で。",
					mapping = "<leader>cco",
					description = "コミット文生成（差分）",
					selection = select.gitdiff,
				},
				CommitStaged = {
					prompt = "ステージ済み変更のコミットメッセージを日本語で。",
					mapping = "<leader>cs",
					description = "コミット文生成（ステージ）",
					selection = function(src)
						return select.gitdiff(src, true)
					end,
				},
			},
		}))
	end,
}
