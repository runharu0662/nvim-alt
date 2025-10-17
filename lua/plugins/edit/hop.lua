return {
    "smoka7/hop.nvim",
    event = "BufRead",
    version = "*",
    opts = {
        multi_windows = false,
    },
    keys = {
        -- <leader><leader> 以下のマッピング
        { "<leader>hw", "<cmd>HopWord<CR>",    mode = "n", desc = "Hop Word" },
        { "<leader>hl", "<cmd>HopLine<CR>",    mode = "n", desc = "Hop Line" },
        { "<leader>hc", "<cmd>HopChar1<CR>",   mode = "n", desc = "Hop Char" },
        { "<leader>hp", "<cmd>HopPattern<CR>", mode = "n", desc = "Hop Pattern" },
        {
            "t",
            "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<CR>",
            mode = { "n", "v", "o" },
            desc = "Hop Before Char in Line (After Cursor)",
        },
        {
            "T",
            "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<CR>",
            mode = { "n", "v", "o" },
            desc = "Hop After Char in Line (Before Cursor)",
        },
    },
}
