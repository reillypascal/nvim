---@module 'lazy'
---@type LazySpec
return {
	"nvim-mini/mini.ai",
	version = false,
	config = function()
		local gen_spec = require("mini.ai").gen_spec
		require("mini.ai").setup({
			custom_textobjects = {
				a = false,
				-- Disable brackets alias in favor of builtin block textobject
				b = false,
				i = false,
				-- https://github.com/nvim-mini/mini.ai/blob/main/doc/mini-ai.txt
				-- '|' blocks for lilypond measures
				-- { "%b||", "^. .* .$" },
				-- Make `|` select both edges in non-balanced way
				["|"] = gen_spec.pair("|", "|", { type = "non-balanced" }),
			},
			-- Module mappings. Use `''` (empty string) to disable one.
			mappings = {
				-- Next/last variants
				-- NOTE: These override built-in LSP selection mappings on Neovim>=0.12
				-- Map LSP selection manually to use it (see `:h MiniAi.config`)
				around_next = "", -- an
				inside_next = "", -- in
				around_last = "", -- al
				inside_last = "", -- il
				-- Move cursor to corresponding edge of `a` textobject
				goto_left = "", -- g[
				goto_right = "", -- g]
			},
			-- How to search for object (first inside current line, then inside
			-- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
			-- 'cover_or_nearest', 'next', 'previous', 'nearest'.
			search_method = "cover_or_next",
			-- Whether to disable showing non-error feedback
			-- This also affects (purely informational) helper messages shown after
			-- idle time if user input is required.
			silent = true,
		})
	end,
}
