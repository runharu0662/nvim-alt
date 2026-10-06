-- ========= PasteClipboardImage: save clipboard image to vault and insert markdown link =========
vim.api.nvim_create_user_command("PasteClipboardImage", function()
	local filename = os.date("%Y-%m-%d_%H-%M-%S") .. ".png"
	if not vim.g.obsidian_vault_path or vim.g.obsidian_vault_path == "" then
		vim.notify(
			"Obsidian vault path is not set. Please set vim.g.obsidian_vault_path in your init.lua.",
			vim.log.levels.ERROR
		)
		return
	end
	local dir = vim.g.obsidian_vault_path .. "/screen_shots"
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

-- Helper: Extract the [[filename]] under the cursor
local function get_link_under_cursor()
	local line = vim.api.nvim_get_current_line()
	local col = vim.fn.col(".")
	local start, finish = nil, nil

	-- Search for [[...]] pattern in the current line
	for s, e in line:gmatch("()%[%[.-%]%]()", 1) do
		if col >= s and col < e then
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
	vim.cmd("edit " .. vim.fn.fnameescape(path))
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

	vim.cmd("edit " .. vim.fn.fnameescape(path))
end

-- Create user commands :CreateMdLink and :OpenMdLink
vim.api.nvim_create_user_command("CreateMdLink", create_md_link, {})
vim.api.nvim_create_user_command("OpenMdLink", open_md_link, {})
