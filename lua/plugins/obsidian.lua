---@module 'lazy'
---@type LazySpec
return {
	"obsidian-nvim/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	ft = "markdown",
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	-- event = {
	--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
	--   -- refer to `:h file-pattern` for more examples
	--   "BufReadPre path/to/my-vault/*.md",
	--   "BufNewFile path/to/my-vault/*.md",
	-- },
	---@module 'obsidian'
	---@type obsidian.config
	opts = {
		callbacks = {
			enter_note = function(_) -- argument represents note
				local actions = require("obsidian.actions")
				vim.keymap.set("n", "<localleader>x", actions.toggle_checkbox, {
					buffer = true,
					desc = "Toggle checkbox",
				})

				vim.keymap.del("n", "]o", { buffer = true })
				vim.keymap.del("n", "[o", { buffer = true })
				vim.keymap.set("n", "]w", function()
					actions.nav_link("next")
				end, { buffer = true, desc = "Go to next link" })
				vim.keymap.set("n", "[w", function()
					actions.nav_link("prev")
				end, { buffer = true, desc = "Go to previous link" })
			end,
		},
		footer = {
			enabled = true,
			separator = "--------------",
			format = "[{{backlinks}} backlinks]",
			hl_group = "@comment",
		},
		frontmatter = {
			enabled = false,
		},
		legacy_commands = false, -- this will be removed in the next major release
		workspaces = {
			{
				name = "Notes",
				path = "~/Sync/Notes",
			},
			{
				name = "Personal",
				path = "~/Sync/Personal",
			},
			{ name = "Household", path = "~/Sync (Household)" },
		},
		ui = {
			-- 'true' requires conceallevel = 1/2
			enable = true,
			external_link_icon = { char = "", hl_group = "Comment" }, -- Constant
			tags = { hl_group = "Special" },
		},
	},
}
