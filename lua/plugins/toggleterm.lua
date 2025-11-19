return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    -- https://github.com/akinsho/toggleterm.nvim?tab=readme-ov-file#setup
    opts = {
      size = function(term)
        if term.direction == 'horizontal' then
          return 15
        elseif term.direction == 'vertical' then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<c-\>]],
      shade_terminals = false,
    },
  },
}
