return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			suggestion = {
				enabled = false,
				auto_trigger = false,
			},
			panel = { enabled = false },
			filetypes = {
				["*"] = true,
			},
		})
	end,
}
