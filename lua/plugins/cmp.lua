return {
	"hrsh7th/nvim-cmp",
	dependences = {
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		
    local cmp = require 'cmp'
    local map = cmp.mapping

    cmp.setup {
      mapping = map.preset.insert {
        ['<C-d>'] = map.scroll_docs(-4),
        ['<C-f>'] = map.scroll_docs(4),
        ['<C-Space>'] = map.complete(),
        ['<C-e>'] = map.abort(),
        ['<CR>'] = map.confirm { select = false },
      },
    }

	vim.lsp.config("*", {
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		}),
	end,
}
