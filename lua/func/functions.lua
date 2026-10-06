-- ========= RunInput： create/open stdin.txt for input =========
vim.api.nvim_create_user_command("RunInput", function()
	local path = vim.fn.getcwd() .. "/stdin.txt"
	vim.fn.writefile({}, path)
	vim.cmd("split " .. vim.fn.fnameescape(path))
	vim.cmd("resize 10")
end, {})

-- ========= InsTemp: insert template from file =========
vim.api.nvim_create_user_command("InsTemp", function()
	local template_path = vim.fn.stdpath("config") .. "/template/base.cpp"
	if vim.fn.filereadable(template_path) == 1 then
		vim.cmd("0r " .. vim.fn.fnameescape(template_path))
	else
		vim.notify("Template not found: " .. template_path, vim.log.levels.WARN)
	end
end, {})

-- ========= Diagnostics: show floating diagnostic on CursorHold =========
vim.opt.updatetime = 500

local diag_group = vim.api.nvim_create_augroup("runharu_diag_float", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
	group = diag_group,
	callback = function(args)
		local buf = args.buf
		local ft = vim.bo[buf].filetype
		if ft == "nvimtree" or ft == "neogitcommitmessage" then
			return
		end

		local buf_group = vim.api.nvim_create_augroup("runharu_diag_float_" .. buf, { clear = true })
		vim.api.nvim_create_autocmd("CursorHold", {
			group = buf_group,
			buffer = buf,
			callback = function()
				vim.diagnostic.open_float(nil, { focus = false, border = "rounded" })
			end,
		})
	end,
})
