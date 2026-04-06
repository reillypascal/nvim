-- Highlight todo, notes, etc in comments
---@module 'lazy'
---@type LazySpec
return {
	"folke/todo-comments.nvim",
	event = "VimEnter",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = function(_, opts)
		opts.signs = false
		vim.keymap.set("n", "]c", function()
			require("todo-comments").jump_next()
		end, { desc = "Next todo comment" })

		vim.keymap.set("n", "[c", function()
			require("todo-comments").jump_prev()
		end, { desc = "Previous todo comment" })
	end,
}
