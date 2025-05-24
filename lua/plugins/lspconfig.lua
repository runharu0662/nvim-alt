return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lspconfig = require("lspconfig")
        lspconfig.clangd.setup({
            cmd = {
                "--std=c++20",
            },
        })
    end,
}
