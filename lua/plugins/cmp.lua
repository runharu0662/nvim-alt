return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
    },

    config = function()
        local cmp = require("cmp")
        local map = cmp.mapping

        cmp.setup({
            completion = {
                completeopt = "menu,menuone,noinsert",
            },
            mapping = map.preset.insert({
                ["<C-p>"] = map.select_prev_item(),
                ["<C-n>"] = map.select_next_item(),
                ["<CR>"] = map.confirm({ select = false }),
                ["<Tab>"] = map.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
            }),
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
        })

        vim.lsp.config("*", {
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
        })
    end,
}
