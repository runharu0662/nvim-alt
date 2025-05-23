return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      theme = 'hyper'    -- theme is doom and hyper default is hyper
      disable_move       -- default is false disable move keymap for hyper
      shortcut_type      -- shortcut type 'letter' or 'number'
      shuffle_letter     -- default is false, shortcut 'letter' will be randomize, set to false to have ordered letter
      letter_list        -- default is a-z, excluding j and k
      change_to_vcs_root -- default is false,for open file in hyper mru. it will change to the root of vcs
      config = {
        shortcut = {
          -- action can be a function type
          { desc = string, group = 'highlight group', key = 'shortcut key', action = 'action when you press key' },
        },
        packages = { enable = true }, -- show how many plugins neovim loaded
        -- limit how many projects list, action when you press key or enter it will run this action.
        -- action can be a function type, e.g.
        -- action = func(path) vim.cmd('Telescope find_files cwd=' .. path) end
        project = { enable = true, limit = 8, icon = 'your icon', label = '', action = 'Telescope find_files cwd=' },
        mru = { enable = true, limit = 10, icon = 'your icon', label = '', cwd_only = false },
        footer = {}, -- footer
      }
      hide = {
        statusline       -- hide statusline default is true
        tabline          -- hide the tabline
        winbar           -- hide winbar
      },
      preview = {
        command          -- preview command
        file_path        -- preview file path
        file_height      -- preview file height
        file_width       -- preview file width
      },
    }
  end,
  dependencies = { {'nvim-tree/nvim-web-devicons'}}
}
