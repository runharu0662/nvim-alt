local icons = require("user.icons")

local M = {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        globalstatus = true,
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
            },
        },
    },
    event = "VeryLazy",
}

return M
