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
		-- callbacks = {
		-- 	enter_note = function(note)
		-- 		vim.keymap.set("n", "<leader>oi", "<cmd>Obsidian toc<cr>", {
		-- 			buffer = note.bufnr,
		-- 			desc = "Obsidian TOC",
		-- 		})
		-- 	end,
		-- },
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
			enable = false,
		},
	},
}
