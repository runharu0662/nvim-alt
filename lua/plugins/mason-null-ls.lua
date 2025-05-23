return {
  "jay-babu/mason-null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "nvimtools/none-ls.nvim", -- ← 最新名
  },
  opts = {
    automatic_setup = true,
    handlers = {},
  },
}

