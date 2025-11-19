return {
  'davidgranstrom/scnvim',
  ft = 'supercollider',
  config = function()
    local scnvim = require 'scnvim'
    local map = scnvim.map
    local map_expr = scnvim.map_expr

    scnvim.setup {
      keymaps = {
        -- ['<M-e>'] = map('editor.send_line', { 'i', 'n' }),
        ['<S-CR>'] = map('editor.send_line', { 'i', 'n' }),
        -- ['<C-e>'] = {
        ['<C-CR>'] = {
          map('editor.send_block', { 'i', 'n' }),
          map('editor.send_selection', 'x'),
        },
        ['<CR>'] = map 'postwin.toggle',
        ['<M-CR>'] = map('postwin.toggle', 'i'),
        ['<M-L>'] = map('postwin.clear', { 'n', 'i' }),
        ['<C-k>'] = map('signature.show', { 'n', 'i' }),
        -- ['<F12>'] = map('sclang.hard_stop', { 'n', 'x', 'i' }),
        ['<C-.>'] = map('sclang.hard_stop', { 'n', 'x', 'i' }),
        ['<leader>st'] = map 'sclang.start',
        ['<leader>sk'] = map 'sclang.recompile',
        ['<F1>'] = map_expr 's.boot',
        ['<F2>'] = map_expr 's.meter',
      },
      editor = {
        highlight = {
          color = 'IncSearch',
        },
      },
      -- this block makes docs appear in nvim; independent of telescope scdoc
      --[[documentation = {
        cmd = '/opt/homebrew/bin/pandoc',
      },]]
      --
      postwin = {
        float = {
          enabled = true,
        },
      },
      extensions = {
        ['fzf-sc'] = {
          search_plugin = 'nvim-fzf',
        },
      },
    }
  end,
}
