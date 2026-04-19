---@module 'lazy'
---@type LazySpec
return {
	-- https://cmp.saghen.dev/installation#lazy-nvim
	"saghen/blink.cmp",
	event = "VimEnter",
	version = "1.*",
	-- lazy = false,
	dependencies = {
		-- needed for nvim-lilypond-suite dictionary as completion source
		"Kaiser-Yang/blink-cmp-dictionary",
	},
	--- @module 'blink.cmp'
	--- @type blink.cmp.Config
	opts = {
		keymap = {
			-- 'default' (recommended) for mappings similar to built-in completions
			-- `:help ins-completion`
			--   <c-y> to accept ([y]es) the completion.
			--    This will auto-import if your LSP supports it.
			--    This will expand snippets if the LSP sent a snippet.
			-- 'super-tab' for tab to accept
			-- 'enter' for enter to accept
			-- 'none' for no mappings
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

			-- More advanced Luasnip keymaps (e.g. selecting choice nodes, expansion):
			--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
		},

		appearance = {
			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		},

		completion = {
			-- Press `<c-space>` to show the documentation.
			-- Set `auto_show = true` to show the documentation after a delay.
			documentation = { auto_show = false, auto_show_delay_ms = 500 },
		},

		sources = {
			-- nvim-lilypond-suite completions: https://github.com/martineausimon/nvim-lilypond-suite/wiki/2.-Configuration#configuration-example
			-- removed "buffer" - completes from everything in the buffer
			default = { "dictionary", "lazydev", "lsp", "path", "snippets" },
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
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					-- make lazydev completions top priority (see `:h blink.cmp`)
					score_offset = 100,
				},
			},
		},

		-- `:h blink-cmp-config-fuzzy`
		-- fuzzy = { implementation = "lua" },
		fuzzy = { implementation = "prefer_rust_with_warning" },

		-- Shows a signature help window while you type arguments for a function
		signature = { enabled = true },
	},
}
