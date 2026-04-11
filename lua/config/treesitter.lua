-- iterate through list of installed_ft
-- or pass installed_ft as list
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*" },
	callback = function()
		pcall(vim.treesitter.start)
	end,
	desc = "Auto-enable treesitter",
})
