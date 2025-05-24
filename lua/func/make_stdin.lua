vim.api.nvim_create_user_command("RunInput", function()
	local path = vim.fn.getcwd() .. "/stdin.txt"

	-- 無理やり空ファイルで上書き作成（内容問わず上書き）
	vim.fn.writefile({}, path)

	-- horizontal split で下に開く
	vim.cmd("split " .. path)
	vim.cmd("resize 10") -- 高さを10行に調整（お好みで）
end, {})
