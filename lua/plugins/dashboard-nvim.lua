-- local header = [[
--                                          ▟▙
--                                          ▝▘
--  ██▃▅▇█▆▖  ▗▟████▙▖   ▄████▄   ██▄  ▄██  ██  ▗▟█▆▄▄▆█▙▖
--  ██▛▔ ▝██  ██▄▄▄▄██  ██▛▔▔▜██  ▝██  ██▘  ██  ██▛▜██▛▜██
--  ██    ██  ██▀▀▀▀▀▘  ██▖  ▗██   ▜█▙▟█▛   ██  ██  ██  ██
--  ██    ██  ▜█▙▄▄▄▟▊  ▀██▙▟██▀   ▝████▘   ██  ██  ██  ██
--  ▀▀    ▀▀   ▝▀▀▀▀▀     ▀▀▀▀       ▀▀     ▀▀  ▀▀  ▀▀  ▀▀
-- ]]

-- local header = [[
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
-- ]]

local header = [[
                       _           
 _ __   ___  _____   _(_)_ __ ___  
| '_ \ / _ \/ _ \ \ / / | '_ ` _ \ 
| | | |  __/ (_) \ V /| | | | | | |
|_| |_|\___|\___/ \_/ |_|_| |_| |_|

]]

return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      change_to_vcs_root = true,
      config = {
        header = vim.split(string.rep('\n', 2) .. header, '\n'),
        footer = {},
        shortcut = {
          { desc = '󰚰 Update', group = '@property', action = 'Lazy update', key = 'u' },
          {
            icon = '󰦨 ',
            icon_hl = '@variable',
            desc = 'New',
            group = 'Label',
            action = 'enew',
            key = 'n',
          },
          {
            icon = ' ',
            icon_hl = '@variable',
            desc = 'Browse',
            group = 'Label',
            action = 'Oil',
            key = 'r',
          },
          {
            icon = ' ',
            icon_hl = '@variable',
            desc = 'Search',
            group = 'Label',
            action = 'Telescope find_files',
            key = 's',
          },
        },
      },
    }
  end,
  dependencies = { { 'nvim-tree/nvim-web-devicons' } },
}
