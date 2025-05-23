local icons = require("user.icons")

local M = {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        options = {
            theme = "dracula",
            globalstatus = true, -- ✅ グローバルステータスラインを有効化
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
        },
        sections = {
            lualine_b = {
                {
                    "branch",
                    icon = icons.branch_icon,
                    color = function()
                        return { gui = "bold" } -- ⛔ カラーを固定せず関数で遅延評価（テーマによる上書きを防ぐ）
                    end,
                },
                {
                    "diagnostics",
                    symbols = {
                        error = icons.error_icon,
                        warn = icons.warn_icon,
                        hint = icons.hint_icon,
                        info = icons.info_icon,
                    },
                },
            },
            lualine_c = {
                {
                    "diff",
                    symbols = {
                        added = icons.added_icon,
                        modified = icons.modified_icon,
                        removed = icons.removed_icon,
                    },
                },
                {
                    function()
                        local file = vim.fn.expand("%:t")
                        if file == "" then
                            return "[No Name]"
                        end
                        local icon = icons.code_icon .. file
                        if vim.bo.modified then
                            icon = icon .. " " .. icons.modified_icon
                        end
                        if vim.bo.readonly then
                            icon = icon .. " " .. icons.readonly_icon
                        end
                        return icon
                    end,
                    color = function()
                        return { fg = "#f9e2af", gui = "bold" } -- 遅延評価で上書きを防ぐ
                    end,
                },
                {
                    "filetype",
                    color = function()
                        return { fg = "#f5c2e7", gui = "bold" }
                    end,
                },
            },
            lualine_x = {
                {
                    "encoding",
                    color = function()
                        return { fg = "#f5c2e7", gui = "bold" }
                    end,
                },
                {
                    function()
                        local fmt = vim.bo.fileformat
                        if fmt == "unix" then
                            return icons.linux_icon
                        elseif fmt == "dos" then
                            return icons.win_icon
                        elseif fmt == "mac" then
                            return icons.mac_icon
                        end
                    end,
                    color = function()
                        return { fg = "#89b4fa" }
                    end,
                },
            },
        },
    },
    event = "VeryLazy",
}

return M

