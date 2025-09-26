-- ========= Vault ルート（1か所だけで管理） =========
local VAULT = vim.fn.expand("~/Documents/Latest_Documents/Obsidian_Vaults/obsidian-vault1/Obsidian_Vault1")

-- ========= RunInput：CWD に stdin.txt を作って下に開く =========
vim.api.nvim_create_user_command("RunInput", function()
	local path = vim.fn.getcwd() .. "/stdin.txt"
	vim.fn.writefile({}, path) -- 空で作成/上書き
	vim.cmd("split " .. vim.fn.fnameescape(path)) -- パスをエスケープ
	vim.cmd("resize 10")
end, {})

-- ========= InsTemp：テンプレを現在バッファ先頭へ挿入 =========
vim.api.nvim_create_user_command("InsTemp", function()
	local template_path = vim.fn.expand("~/.config/nvim-alt/template/base.cpp") -- ~ を展開
	if vim.fn.filereadable(template_path) == 1 then
		vim.cmd("0r " .. vim.fn.fnameescape(template_path))
	else
		vim.notify("Template not found: " .. template_path, vim.log.levels.WARN)
	end
end, {})

-- ========= Diagnostics：CursorHold で浮動ウィンドウ表示（重複防止） =========
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

		-- バッファ専用の CursorHold（再読込時も重複しない）
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
-- ※ 以前のグローバルな CursorHold/CursorHoldI は削除（重複発火の原因）

-- ========= PasteClipboardImage：画像を VAULT/screen_shots へ保存してリンク挿入 =========
vim.api.nvim_create_user_command("PasteClipboardImage", function()
	local filename = os.date("%Y-%m-%d_%H-%M-%S") .. ".png"
	local dir = VAULT .. "/screen_shots"
	local full_path = dir .. "/" .. filename

	vim.fn.mkdir(dir, "p")
	vim.fn.system({ "pngpaste", full_path })

	if vim.v.shell_error == 0 and vim.fn.filereadable(full_path) == 1 then
		local markdown = string.format("![image](screen_shots/%s)", filename)
		vim.fn.append(vim.fn.line("."), markdown) -- 現在行の次行に追記（従来と同じ操作感）
		print("✅ Image saved: " .. filename)
	else
		print("❌ Failed to paste image from clipboard.")
	end
end, {})
