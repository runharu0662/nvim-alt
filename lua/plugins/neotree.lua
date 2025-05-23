local icons = require("user.icons")
return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	lazy = false, -- neo-tree will lazily load itself
	---@module "neo-tree"
	---@type neotree.Config?
	opts = {
		window = {
			width = 30,
			mappings = {
				["l"] = "open",
				["h"] = "close_node",
			},
		},
	},
    default_component_configs = {
        diagnostics = {
            symbols = {
                hint = icons.hint_icon,
                info = icons.info_icon,
                warn = icons.warn_icon,
                error = icons.error_icon,
            },
        },
        modified = {
            symbol = icons.modified_icon,
        },
        git_status = {
            symbols = {
                -- Change type
                added = icons.added_icon,
                modified = icons.modified_icon,
                deleted = icons.deleted_icon,
                renamed = icons.renamed_icon,
                -- Status type
                untracked = icons.untracked_icon,
                ignored = icons.ignored_icon,
                unstaged = icons.unstaged_icon,
                staged = icons.staged_icon,
                conflict = icons.conflict_icon,
            },
        },
    },
}
