return {
    "folke/noice.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    config = function()
        require("noice").setup({
            cmdline = {
                enabled = false,
            },
            messages = {
                enabled = true,
            },
            popupmenu = {
                enabled = true,
            },
        })
        require("notify").setup({
            background_colour = "#000000",
            stages = "fade_in_slide_out",
            timeout = 3000,
            max_width = 80,
            max_height = 10,
            top_down = false,
        })
    end,
}
