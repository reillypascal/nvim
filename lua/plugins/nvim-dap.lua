return {
  -- "Built-in support for many task frameworks (make, npm, cargo, .vscode/tasks.json, etc)"
  'mfussenegger/nvim-dap',
  --event = 'VeryLazy',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'jay-babu/mason-nvim-dap.nvim',
    'theHamsta/nvim-dap-virtual-text',
  },
  keys = {
    {
      '<leader>db',
      function()
        require('dap').list_breakpoints()
      end,
      desc = 'DAP Breakpoints',
    },
    {
      '<leader>ds',
      function()
        local widgets = require 'dap.ui.widgets'
        widgets.centered_float(widgets.scopes, { border = 'rounded' })
      end,
      desc = 'DAP Scopes',
    },
    {
      '<F1>',
      function()
        require('dap.ui.widgets').hover(nil, { border = 'rounded' })
      end,
    },
    { '<F4>', '<CMD>DapDisconnect<CR>', desc = 'DAP Disconnect' },
    { '<F16>', '<CMD>DapTerminate<CR>', desc = 'DAP Terminate' },
    { '<F5>', '<CMD>DapContinue<CR>', desc = 'DAP Continue' },
    {
      '<F17>',
      function()
        require('dap').run_last()
      end,
      desc = 'Run Last',
    },
    {
      '<F6>',
      function()
        require('dap').run_to_cursor()
      end,
      desc = 'Run to Cursor',
    },
    { '<F9>', '<CMD>DapToggleBreakpoint<CR>', desc = 'Toggle Breakpoint' },
    {
      '<F21>',
      function()
        vim.ui.input({ prompt = 'Breakpoint condition: ' }, function(input)
          require('dap').set_breakpoint(input)
        end)
      end,
      desc = 'Conditional Breakpoint',
    },
    { '<F10>', '<CMD>DapStepOver<CR>', desc = 'Step Over' },
    { '<F11>', '<CMD>DapStepInto<CR>', desc = 'Step Into' },
    { '<F12>', '<CMD>DapStepOut<CR>', desc = 'Step Out' },
  },
  config = function()
    local dap = require 'dap'
    dap.adapters.codelldb = {
      type = 'executable',
      command = 'codelldb', -- or if not in $PATH: "/absolute/path/to/codelldb"

      -- On windows you may have to uncomment this:
      -- detached = false,
    }
  end,
}
