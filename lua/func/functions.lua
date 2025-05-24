vim.api.nvim_create_user_command("RunInput", function()
	local path = vim.fn.getcwd() .. "/stdin.txt"

	-- 無理やり空ファイルで上書き作成（内容問わず上書き）
	vim.fn.writefile({}, path)

	-- horizontal split で下に開く
	vim.cmd("split " .. path)
	vim.cmd("resize 10") -- 高さを10行に調整（お好みで）
end, {})

-- テンプレートファイルの挿入コマンド
vim.api.nvim_create_user_command("InsTemp", function()
	-- テンプレートファイルのパスを指定
	local template_path = "~/.config/nvim-alt/template/base.cpp"

	-- テンプレートファイルの内容を現在のバッファに挿入
	vim.cmd("0r " .. template_path)
end, {})

-- 参考:https://qiita.com/nao-a/items/631bd5aa3bd20b2b3da1
vim.opt.updatetime = 1000

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local ft = vim.bo[args.buf].filetype
		if ft == "NvimTree" or ft == "NeogitCommitMessage" then
			return
		end

		vim.api.nvim_create_autocmd({ "CursorHold" }, {
			buffer = args.buf,
			callback = function()
				vim.diagnostic.open_float(nil, { focus = false })
				-- lspsagaのhover使うなら：
				-- require('lspsaga.hover').render_hover_doc()
			end,
		})
	end,
})
