return {
    "github/copilot.vim",
    lazy = false,
    config = function()
        local copilot_state_file = vim.fn.stdpath("data") .. "/copilot_state"

        local function save_copilot_state(state)
            local file = io.open(copilot_state_file, "w")
            if file then
                file:write(state and "1" or "0")
                file:close()
            end
        end

        local function load_copilot_state()
            local file = io.open(copilot_state_file, "r")
            if file then
                local state = file:read("*a")
                file:close()
                return tonumber(state) == 1
            end
            return true
        end

        vim.g.copilot_enabled = load_copilot_state() and 1 or 0
        if vim.g.copilot_enabled == 1 then
            vim.cmd("Copilot enable")
        else
            vim.cmd("Copilot disable")
        end

        vim.api.nvim_create_user_command("ToggleCopilot", function()
            if vim.g.copilot_enabled == 1 then
                vim.cmd("Copilot disable")
                vim.g.copilot_enabled = 0
                print("Copilot disabled")
            else
                vim.cmd("Copilot enable")
                vim.g.copilot_enabled = 1
                print("Copilot enabled")
            end
            save_copilot_state(vim.g.copilot_enabled == 1)
        end, {})

        local keymap = vim.keymap.set

        keymap(
            "i",
            "<C-g>",
            'copilot#Accept("<CR>")',
            { silent = true, expr = true, script = true, replace_keycodes = false, desc = "Copilot accept suggestion" }
        )
        keymap("i", "<C-j>", "<Plug>(copilot-next)", { desc = "Copilot next suggestion" })
        keymap("i", "<C-k>", "<Plug>(copilot-previous)", { desc = "Copilot previous suggestion" })
        keymap("i", "<C-o>", "<Plug>(copilot-dismiss)", { desc = "Copilot dismiss suggestion" })
        keymap("i", "<C-s>", "<Plug>(copilot-suggest)", { desc = "Copilot suggest manually" })

        keymap(
            "n",
            "<leader>lc",
            ":ToggleCopilot<CR>",
            { noremap = true, silent = true, desc = "Toggle Github Copilot" }
        )
    end,
}
