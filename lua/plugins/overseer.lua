return {
  'stevearc/overseer.nvim',
  opts = {},
  config = function()
    require('overseer').setup {
      -- https://github.com/stevearc/overseer.nvim/blob/master/doc/third_party.md#toggleterm
      strategy = 'toggleterm',
    }
  end,
}
