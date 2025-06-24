-- open horizontal split stdin.txt
vim.api.nvim_create_user_command("RunInput", function()
	local path = vim.fn.getcwd() .. "/stdin.txt"

	vim.fn.writefile({}, path)

	vim.cmd("split " .. path)
	vim.cmd("resize 10") -- 高さを10行に調整（お好みで）
end, {})

-- Insert cpp template
vim.api.nvim_create_user_command("InsTemp", function()
	local template_path = "~/.config/nvim-alt/template/base.cpp"

	vim.cmd("0r " .. template_path)
end, {})

-- reference: https://qiita.com/nao-a/items/631bd5aa3bd20b2b3da1
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

-- Helper: Extract the [[filename]] under the cursor
local function get_link_under_cursor()
	local line = vim.api.nvim_get_current_line()
	local col = vim.fn.col(".") - 1
	local start, finish = nil, nil

	-- Search for [[...]] pattern in the current line
	for s, e in line:gmatch("()%[%[.-%]%]()", 1) do
		if col >= s and col <= e then
			start = s
			finish = e - 3 -- exclude the final closing bracket (]])
			break
		end
	end

	if not start then
		return nil
	end

	local name = line:sub(start + 2, finish) -- remove opening brackets ([[)
	return name ~= "" and name or nil
end

-- Helper: Get the full .md file path in the current buffer's directory
local function get_md_file_path(filename)
	local dir = vim.fn.expand("%:p:h")
	return dir .. "/" .. filename .. ".md"
end

-- Create a markdown file if it does not already exist, then open it
local function create_md_link()
	local filename = get_link_under_cursor()
	if not filename then
		vim.notify("No [[filename]] under cursor.", vim.log.levels.WARN)
		return
	end

	local path = get_md_file_path(filename)
	if vim.fn.filereadable(path) == 1 then
		vim.notify("File already exists: " .. path, vim.log.levels.INFO)
		return
	end

	vim.fn.writefile({}, path) -- create empty file
	vim.notify("Markdown file created: " .. path, vim.log.levels.INFO)
	vim.cmd("edit " .. path)
end

-- Open an existing markdown file based on the [[filename]] under cursor
local function open_md_link()
	local filename = get_link_under_cursor()
	if not filename then
		vim.notify("No [[filename]] under cursor.", vim.log.levels.WARN)
		return
	end

	local path = get_md_file_path(filename)
	if vim.fn.filereadable(path) == 0 then
		vim.notify("Markdown file not found: " .. path, vim.log.levels.ERROR)
		return
	end

	vim.cmd("edit " .. path)
end

-- Create user commands :CreateMdLink and :OpenMdLink
vim.api.nvim_create_user_command("CreateMdLink", create_md_link, {})
vim.api.nvim_create_user_command("OpenMdLink", open_md_link, {})
