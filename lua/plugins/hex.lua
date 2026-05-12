return {
	"RaafatTurki/hex.nvim",
	keys = {
		{
			"<leader>ha",
			function()
				require("hex").assemble()
			end,
			mode = "",
			desc = "[H]ex [A]ssemble",
		},
		{
			"<leader>hd",
			function()
				require("hex").dump()
			end,
			mode = "",
			desc = "[H]ex [D]ump",
		},
		{
			"<leader>ht",
			function()
				require("hex").toggle()
			end,
			mode = "",
			desc = "[H]ex [T]oggle",
		},
	},
	config = function()
		require("hex").setup()
	end,
}
