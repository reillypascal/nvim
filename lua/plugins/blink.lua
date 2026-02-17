return { -- Autocompletion
	"saghen/blink.cmp",
	event = "VimEnter",
	version = "1.*",
	lazy = false,
	dependencies = {
		-- Snippet Engine
		{
			"L3MON4D3/LuaSnip",
			version = "2.*",
			build = (function()
				-- Build Step is needed for regex support in snippets.
				-- This step is not supported in many windows environments.
				-- Remove the below condition to re-enable on windows.
				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
					return
				end
				return "make install_jsregexp"
			end)(),
			-- https://www.reddit.com/r/neovim/comments/1mh01t1/noob_question_how_do_i_properly_integrate_luasnip/
			config = function()
				require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snippets" })
			end,
			dependencies = {
				-- `friendly-snippets` contains a variety of premade snippets.
				--    See the README about individual language/framework/plugin snippets:
				--    https://github.com/rafamadriz/friendly-snippets
				-- {
				--   'rafamadriz/friendly-snippets',
				--   config = function()
				--     require('luasnip.loaders.from_vscode').lazy_load()
				--   end,
				-- },
			},
			opts = {
				enable_autosnippets = true,
			},
		},
		"folke/lazydev.nvim",
		-- needed for nvim-lilypond-suite dictionary as completion source
		"Kaiser-Yang/blink-cmp-dictionary",
	},
	--- @module 'blink.cmp'
	--- @type blink.cmp.Config
	opts = {
		keymap = {
			-- 'default' (recommended) for mappings similar to built-in completions
			--   <c-y> to accept ([y]es) the completion.
			--    This will auto-import if your LSP supports it.
			--    This will expand snippets if the LSP sent a snippet.
			-- 'super-tab' for tab to accept
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			--
			-- For an understanding of why the 'default' preset is recommended,
			-- you will need to read `:help ins-completion`
			--
			-- No, but seriously. Please read `:help ins-completion`, it is really good!
			--
			-- All presets have the following mappings:
			-- <tab>/<s-tab>: move to right/left of your snippet expansion
			-- <c-space>: Open menu or open docs if already open
			-- <c-n>/<c-p> or <up>/<down>: Select next/previous item
			-- <c-e>: Hide menu
			-- <c-k>: Toggle signature help
			--
			-- See :h blink-cmp-config-keymap for defining your own keymap
			preset = "default",

			-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
			--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
		},

		appearance = {
			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		},

		completion = {
			-- By default, you may press `<c-space>` to show the documentation.
			-- Optionally, set `auto_show = true` to show the documentation after a delay.
			documentation = { auto_show = false, auto_show_delay_ms = 500 },
		},

		sources = {
			-- nvim-lilypond-suite completions: https://github.com/martineausimon/nvim-lilypond-suite/wiki/2.-Configuration#configuration-example
			-- removed "buffer" - completes from everything in the buffer
			default = { "dictionary", "lsp", "path", "snippets", "lazydev" }, -- seems to need "markdown_oxide" in order to use
			providers = {
				-- dictionary table is for nvim-lilypond-suite (so far)
				-- note that $LILYDICTPATH didn't need to be added to .zshenv
				dictionary = {
					module = "blink-cmp-dictionary",
					name = "Dict",
					min_keyword_length = 3,
					max_items = 8,
					opts = {
						dictionary_files = function()
							if vim.bo.filetype == "lilypond" then
								return vim.fn.glob(vim.fn.expand("$LILYDICTPATH") .. "/*", true, true)
							end
						end,
					},
				},
				lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
				-- lsp = {
				-- Configure markdown_oxide for better keyword matching
				-- markdown_oxide = {
				-- 	module = "", -- seems to want this
				-- 	keyword_pattern = [[\(\k\| \|\/\|#\)\+]],
				-- },
				-- },
			},
		},

		snippets = { preset = "luasnip" },

		-- Blink.cmp includes an optional, recommended rust fuzzy matcher,
		-- which automatically downloads a prebuilt binary when enabled.
		--
		-- By default, we use the Lua implementation instead, but you may enable
		-- the rust implementation via `'prefer_rust_with_warning'`
		--
		-- See :h blink-cmp-config-fuzzy for more information
		-- fuzzy = { implementation = "lua" },
		fuzzy = { implementation = "prefer_rust_with_warning" },

		-- Shows a signature help window while you type arguments for a function
		signature = { enabled = true },
	},
}
