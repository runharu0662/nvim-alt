return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    opts = {
        cmdline = {
            view = "cmdline_popup",
        },
        messages = {
            view = "mini",
            view_error = "mini",
            view_warn = "mini",
            view_history = "messages",
            view_search = "virtualtext",
        },
    },
}
