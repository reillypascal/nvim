return {
	"reillypascal/perf.nvim",
	-- dir = "~/Dev/Neovim/perf.nvim",
	lazy = false,
	priority = 1000, -- Make sure to load this before all the other start plugins.
	config = function()
		vim.cmd.colorscheme("perf")
		--vim.cmd.colorscheme 'default'
	end,
}
