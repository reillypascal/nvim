return {
	-- "Built-in support for many task frameworks (make, npm, cargo, .vscode/tasks.json, etc)"
	"https://codeberg.org/mfussenegger/nvim-dap",
	-- ft = { "c", "cpp", "python", "rust" },
	-- event = "VeryLazy",
	lazy = true,
	dependencies = {
		"leoluz/nvim-dap-go",
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-neotest/nvim-nio",
	},
	keys = {
		{
			"<leader>db",
			function()
				require("dap").list_breakpoints()
			end,
			desc = "DAP Breakpoints",
		},
		{
			"<leader>ds",
			function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.scopes, { border = "rounded" })
			end,
			desc = "DAP Scopes",
		},
		{
			"<leader>dw",
			function()
				require("dap.ui.widgets").hover(nil, { border = "rounded" })
			end,
			desc = "DAP UI Widgets",
		},
		{ "<leader>dd", "<CMD>DapDisconnect<CR>", desc = "DAP Disconnect" },
		{ "<leader>dt", "<CMD>DapTerminate<CR>", desc = "DAP Terminate" },
		{ "<leader>dc", "<CMD>DapContinue<CR>", desc = "DAP Continue" },
		{
			"<leader>drl",
			function()
				require("dap").run_last()
			end,
			desc = "DAP Run Last",
		},
		{
			"<leader>drc",
			function()
				require("dap").run_to_cursor()
			end,
			desc = "DAP Run to Cursor",
		},
		{ "<leader>db", "<CMD>DapToggleBreakpoint<CR>", desc = "DAP Toggle Breakpoint" },
		{
			"<leader>dp",
			function()
				vim.ui.input({ prompt = "Breakpoint condition: " }, function(input)
					require("dap").set_breakpoint(input)
				end)
			end,
			desc = "DAP Prompt: Conditional Breakpoint",
		},
		{ "<leader>dsv", "<CMD>DapStepOver<CR>", desc = "DAP Step Over" },
		{ "<leader>dsi", "<CMD>DapStepInto<CR>", desc = "DAP Step Into" },
		{ "<leader>dso", "<CMD>DapStepOut<CR>", desc = "DAP Step Out" },
	},
	config = function()
		local dap = require("dap")
		local ui = require("dapui")

		require("dapui").setup()
		require("dap-go").setup()
		require("nvim-dap-virtual-text").setup({
			-- commented = true, -- show virtual text alongside comment
		})
		-- [[ DAP ADAPTERS ]]
		-- https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
		-- https://microsoft.github.io/debug-adapter-protocol/implementors/adapters/
		dap.adapters.lldb = {
			type = "executable",
			command = "/Applications/Xcode.app/Contents/Developer/usr/bin//lldb-dap",
			name = "lldb",
			-- On windows you may have to uncomment this:
			-- detached = false,
		}
		dap.adapters.python = function(cb, config)
			if config.request == "attach" then
				---@diagnostic disable-next-line: undefined-field
				local port = (config.connect or config).port
				---@diagnostic disable-next-line: undefined-field
				local host = (config.connect or config).host or "127.0.0.1"
				cb({
					type = "server",
					port = assert(port, "`connect.port` is required for a python `attach` configuration"),
					host = host,
					options = {
						source_filetype = "python",
					},
				})
			else
				cb({
					type = "executable",
					command = "python3", -- path/to/virtualenvs/debugpy/bin/python
					args = { "-m", "debugpy.adapter" },
					options = {
						source_filetype = "python",
					},
				})
			end
		end

		-- [[ DAP CONFIGURATIONS ]]
		dap.configurations.c = {
			{
				name = "Launch",
				type = "lldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = {},

				-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
				--
				--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
				--
				-- Otherwise you might get the following error:
				--
				--    Error on launch: Failed to attach to the target process
				--
				-- But you should be aware of the implications:
				-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
				-- runInTerminal = false,
			},
		}
		dap.configurations.cpp = dap.configurations.c
		dap.configurations.python = {
			{
				-- The first three options are required by nvim-dap
				type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
				request = "launch",
				name = "Launch file",

				-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

				program = "${file}", -- This configuration will launch the current file if used.
				pythonPath = function()
					-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
					-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
					-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
					local cwd = vim.fn.getcwd()
					if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
						return cwd .. "/venv/bin/python"
					elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
						return cwd .. "/.venv/bin/python"
					else
						return "python3"
					end
				end,
			},
		}
		dap.configurations.rust = dap.configurations.c
		dap.configurations.zig = dap.configurations.c

		vim.keymap.set("n", "<leader>d?", function()
			require("dapui").eval(nil, { enter = true })
		end, { desc = "DAP: Evaluate Variable under Cursor" })

		dap.listeners.before.attach.dapui_config = function()
			ui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			ui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			ui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			ui.close()
		end
	end,
}
