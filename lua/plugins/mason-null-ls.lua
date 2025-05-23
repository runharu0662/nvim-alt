return {
  "jay-babu/mason-null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "nvimtools/none-ls.nvim",
  },
  config = function()
    local null_ls = require("none-ls") -- ← ここが重要！

    null_ls.setup({})

    require("mason-null-ls").setup({
      automatic_installation = true,
      ensure_installed = {
        "stylua",
        "prettier",
      },
      handlers = {
        function() end, -- 全自動登録を無効化
        stylua = function()
          null_ls.register(null_ls.builtins.formatting.stylua)
        end,
        prettier = function()
          null_ls.register(null_ls.builtins.formatting.prettier)
        end,
      },
    })
  end,
}

