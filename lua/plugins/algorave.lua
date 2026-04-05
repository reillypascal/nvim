return {
	-- dir = "~/Dev/Neovim/algorave.nvim",
	"https://codeberg.org/reillypascal/algorave.nvim",
	-- https://github.com/LazyVim/LazyVim/discussions/4264#discussioncomment-10252426
	opts = function(_, opts)
		local api = require("algorave").api
		opts.start = {
			split_size = "10",
		}
		opts.repl_definitions = {
			haskell = {
				args = { "-ghci-script=" .. vim.fn.expand("$TIDAL_BOOT_PATH") .. "/BootTidal.hs" },
				file = { "*.hs", "*.tidal" },
			},
			scheme = {
				cmd = "lilypond",
				args = { "scheme-sandbox" },
			},
			supercollider = { enabled = false },
		}
		opts.cmd_opts = {}
		opts.treesitter_nodes = {}
		opts.mappings = {
			send_line = {
				mode = { "n" },
				key = "<localleader>e",
				callback = api.send_line,
				desc = "Send current line to REPL",
			},
			send_visual = {
				mode = { "x" },
				key = "<localleader>v",
				callback = api.send_visual,
				desc = "Send current visual selection to REPL",
			},
			send_block = {
				mode = { "n", "x" },
				key = "<localleader>r",
				callback = api.send_block,
				desc = "Send current block to REPL",
			},
			send_node = {
				mode = "n",
				key = "<localleader>t",
				callback = api.send_node,
				desc = "Send current Treesitter node to REPL",
			},
			send_buffer = {
				mode = { "n", "x" },
				key = "<localleader>b",
				callback = api.send_buffer,
				desc = "Send current buffer to REPL",
			},
			send_silence = {
				mode = { "n", "x" },
				key = "<localleader>s",
				callback = function()
					api.send(string.format("d%d silence", vim.v.count1))
				end,
				desc = "Send `d{count} silence` to Tidal",
				language = { "haskell", "tidal" },
			},
			send_hush = {
				mode = { "n", "x" },
				key = "<localleader>.",
				callback = function()
					api.send("hush")
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
		}
	end,
}
