-- TODO: iterate through list of installed ft for pattern, instead of "*"
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*" },
	callback = function()
		pcall(vim.treesitter.start)
	end,
	desc = "Auto-enable treesitter",
})
