return {
    "nvimdev/lspsaga.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter", -- optional
        "nvim-tree/nvim-web-devicons",     -- optional
    },
    config = function()
        require("lspsaga").setup({
            diagnostic = {
                border = "rounded",
            },
            lightbulb = {
                enable = true,
                sign = true,          -- SignColumn に表示
                virtual_text = false, -- VirtualText を無効にすることで行がズレない
            },
        })
    end,
}
