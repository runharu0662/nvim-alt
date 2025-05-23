local icons = require("user.icons")

local M = {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        theme = "dracula",
        sections = {
            lualine_b = {
                {
                    "branch",
                    icon = icons.branch_icon,
                    color = { gui = "bold" },
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
                        -- ファイル名を取得
                        local file = vim.fn.expand("%:t") -- ファイル名を取得（パスなし）

                        -- ファイル名がない場合の表示
                        if file == "" then
                            return "[No Name]"
                        end

                        -- アイコンとファイル名を設定
                        local icon = icons.code_icon .. file

                        -- 変更されたファイルの場合に`modified`アイコンを追加
                        if vim.bo.modified then
                            icon = icon .. " " .. icons.modified_icon
                        end

                        -- 読み取り専用ファイルの場合に`readonly`アイコンを追加
                        if vim.bo.readonly then
                            icon = icon .. " " .. icons.readonly_icon
                        end

                        return icon
                    end,
                    color = { fg = "#f9e2af", gui = "bold" },
                },
                {
                    "filetype",
                    color = { fg = "#f5c2e7", gui = "bold" },
                },
            },
            lualine_x = {
                {
                    "encoding",
                    color = { fg = "#f5c2e7", gui = "bold" },
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
                    color = { fg = "#89b4fa" },
                },
            },
        },
    },
    event = "VeryLazy",
}

return M
