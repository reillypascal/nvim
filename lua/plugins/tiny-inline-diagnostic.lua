return {
  'rachartier/tiny-inline-diagnostic.nvim',
  event = 'VeryLazy',
  priority = 1000,
  config = function()
    require('tiny-inline-diagnostic').setup {
      -- Style preset for diagnostic messages
      -- Available options: "modern", "classic", "minimal", "powerline", "ghost", "simple", "nonerdfont", "amongus"
      preset = 'simple',
      options = {
        -- Display the source of the diagnostic (e.g., basedpyright, vsserver, lua_ls etc.)
        show_source = {
          enabled = true,
          -- Show source only when multiple sources exist for the same diagnostic
          if_many = false,
        },
      },
    }
    vim.diagnostic.config { virtual_text = false } -- Disable default virtual text
  end,
}
