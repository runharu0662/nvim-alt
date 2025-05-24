return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lspconfig = require("lspconfig")
        lspconfig.clangd.setup({
            cmd = {
                "clangd",
                "--clang-tidy",
                "--header-insertion=never",
                "--completion-style=detailed",
                "--pch-storage=memory",
                "--std=c++20",
            },
        })
    end,
}
