return {
	"nvimtools/none-ls.nvim",
	lazy = false,
	dependencies = { "williamboman/mason.nvim", "nvim-lua/plenary.nvim" },
	config = function()
		local null_ls = require("null-ls")
		local tools = require("config.development")
		local function available(command)
			return function(params)
				return tools.executable(command, params.bufname) ~= nil
			end
		end
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.goimports.with({ runtime_condition = available("goimports") }),
				null_ls.builtins.formatting.gofmt.with({
					runtime_condition = function(params)
						return not tools.executable("goimports", params.bufname)
							and tools.executable("gofmt", params.bufname) ~= nil
					end,
				}),
				null_ls.builtins.formatting.prettier.with({ runtime_condition = available("prettier") }),
				null_ls.builtins.formatting.terraform_fmt.with({ runtime_condition = available("terraform") }),
				null_ls.builtins.formatting.shfmt.with({ runtime_condition = available("shfmt") }),
				null_ls.builtins.formatting.stylua.with({ runtime_condition = available("stylua") }),
			},
		})
		tools.setup_formatting()
	end,
}
