---@module 'lazy'
---@type LazySpec
return {
	-- dir = "~/Dev/Neovim/algorave.nvim",
	"https://codeberg.org/reillypascal/algorave.nvim",
	opts = {
		start = {
			split_size = "10",
		},
		repl_definitions = {
			haskell = {
				args = { "-ghci-script=" .. vim.fn.expand("$TIDAL_BOOT_PATH") .. "/BootTidal.hs" },
				file = { "*.hs", "*.tidal" },
			},
			scheme = {
				cmd = "lilypond",
				args = { "scheme-sandbox" },
			},
			supercollider = { enabled = false },
		},
		cmd_opts = {},
		treesitter_nodes = {},
		mappings = {
			send_line = {
				mode = { "n" },
				key = "<localleader>e",
				callback = function()
					require("algorave").api.send_line()
				end,
				desc = "Send current line to REPL",
			},
			send_visual = {
				mode = { "x" },
				key = "<localleader>v",
				callback = function()
					require("algorave").api.send_visual()
				end,
				desc = "Send current visual selection to REPL",
			},
			send_block = {
				mode = { "n", "x" },
				key = "<localleader>r",
				callback = function()
					require("algorave").api.send_block()
				end,
				desc = "Send current block to REPL",
			},
			send_node = {
				mode = "n",
				key = "<localleader>t",
				callback = function()
					require("algorave").api.send_node()
				end,
				desc = "Send current Treesitter node to REPL",
			},
			send_buffer = {
				mode = { "n", "x" },
				key = "<localleader>b",
				callback = function()
					require("algorave").api.send_buffer()
				end,
				desc = "Send current buffer to REPL",
			},
			send_silence = {
				mode = { "n", "x" },
				key = "<localleader>s",
				callback = function()
					require("algorave").api.send(string.format("d%d silence", vim.v.count1))
				end,
				desc = "Send `d{count} silence` to Tidal",
				language = { "haskell", "tidal" },
			},
			send_hush = {
				mode = { "n", "x" },
				key = "<localleader>.",
				callback = function()
					require("algorave").api.send("hush")
				end,
				desc = "Send `hush` to Tidal",
				language = { "haskell", "tidal" },
			},
			start_repl = {
				mode = "n",
				key = "<localleader>as",
				callback = "<cmd>Rave start<cr>",
				desc = "Start the Algorave REPL",
			},
			stop_repl = {
				mode = "n",
				key = "<localleader>aq",
				callback = "<cmd>Rave stop<cr>",
				desc = "Stop the Algorave REPL",
			},
			toggle_term = {
				mode = "n",
				key = "<localleader>aw",
				callback = "<cmd>Rave term<cr>",
				desc = "Toggle the Algorave terminal open/closed",
			},
		},
	},
}
