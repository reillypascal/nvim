return {
	"nvim-mini/mini.ai",
	version = false,
	config = function()
		require("mini.ai").setup({
			custom_textobjects = {
				-- https://github.com/nvim-mini/mini.ai/blob/main/doc/mini-ai.txt
				-- lilypond measures
				{ "%b||", "^. .* .$" },
			},
		})
	end,
}
