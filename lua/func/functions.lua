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
vim.opt.updatetime = 500

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local ft = vim.bo[args.buf].filetype
		if ft == "nvimtree" or ft == "neogitcommitmessage" then
			return
		end

		vim.api.nvim_create_autocmd({ "CursorHold" }, {
			buffer = args.buf,
			callback = function()
				vim.diagnostic.open_float(nil, {
					focus = false,
					border = "rounded", -- ← これを追加
				})
			end,
		})
	end,
})

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
	callback = function()
		vim.diagnostic.open_float(nil, { focus = false })
	end,
})

vim.api.nvim_create_user_command("PasteImage", function()
	local line = vim.fn.getline(".") -- 現在行（画像パス）
	local cmd = { "~/.local/bin/paste-image.sh", line }
	local result = vim.fn.system(cmd)
	vim.fn.setline(".", vim.fn.trim(result))
end, {})
