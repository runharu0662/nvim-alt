return {
  "nvimtools/none-ls.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    local null_ls = require("null-ls") -- ← none-ls はモジュール名まだ "null-ls"
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.prettier,

      },
    })
  end,
}
