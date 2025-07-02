return {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = "ToggleTerm",
    config = function()
        require("toggleterm").setup({
            direction = "float",
            float_opts = {
                border = "rounded",
            },
        })
    end,
}
