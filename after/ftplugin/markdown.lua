-- Keep prose wrapped on screen without inserting newlines into the file.
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true
vim.opt_local.textwidth = 0
vim.opt_local.formatoptions:remove({ "t", "c" })
vim.opt_local.formatoptions:append("mM")
vim.opt_local.conceallevel = 0
vim.opt_local.spell = false

for _, key in ipairs({ "j", "k" }) do
	vim.keymap.set({ "n", "x" }, key, function()
		return vim.v.count == 0 and "g" .. key or key
	end, { buffer = true, expr = true, desc = "Move through wrapped text" })
end
