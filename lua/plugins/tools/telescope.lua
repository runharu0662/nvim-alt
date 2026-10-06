return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		defaults = { vimgrep_arguments = { "rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" } },
		pickers = { find_files = { find_command = vim.fn.executable("fd") == 1 and { "fd", "--type", "f", "--strip-cwd-prefix" } or nil } },
	},
}
