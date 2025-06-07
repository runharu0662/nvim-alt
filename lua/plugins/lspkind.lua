return {
	"onsails/lspkind-nvim",
	config = function()
		local lspkind = require("lspkind")
		local cmp = require("cmp")
		cmp.setup({
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol",
					maxwidth = {
						menu = 50,
						abbr = 50,
					},
					ellipsis_char = "...",
					show_labelDetails = true,

					before = function(entry, vim_item)
						-- ...
						return vim_item
					end,
				}),
			},
			mapping = {
				["<Tab>"] = vim.schedule_wrap(function(fallback)
					if cmp.visible() and has_words_before() then
						cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
					else
						fallback()
					end
				end),
			},
		})
	end,
}
