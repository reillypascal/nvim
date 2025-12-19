return {
	"reillypascal/radio.nvim",
	-- dir = "~/Dev/Neovim/radio.nvim",
	lazy = false,
	priority = 1000, -- Make sure to load this before all the other start plugins.
	config = function()
		vim.cmd.colorscheme("radio")
	end,
}
