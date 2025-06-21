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

-- paste image
vim.api.nvim_create_user_command("PasteClipboardImage", function()
	local filename = os.date("%Y-%m-%d_%H-%M-%S") .. ".png"

	-- $HOME を expand() で取得
	local home = vim.fn.expand("~")

	-- 保存パスを固定で指定
	local vault_path = home
		.. "/Documents/Latest_Documents/Obsidian_Vaults/obsidian-vault1/Obsidian_Vault1/screen_shots"
	local full_path = vault_path .. "/" .. filename

	vim.fn.mkdir(vault_path, "p")
	local result = vim.fn.system({ "pngpaste", full_path })

	if vim.v.shell_error == 0 then
		local markdown = string.format("![image](screen_shots/%s)", filename)
		vim.fn.append(vim.fn.line("."), markdown)
		print("✅ Image saved: " .. filename)
	else
		print("❌ Failed to paste image from clipboard.")
	end
end, {})
