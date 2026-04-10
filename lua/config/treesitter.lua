-- iterate through list of installed_ft
-- or pass installed_ft as list
vim.api.nvim_create_autocmd("FileType", {
	pattern = installed_ft,
	callback = function()
		pcall(vim.treesitter.start)
	end,
	desc = "Auto-enable treesitter for installed parsers",
})
