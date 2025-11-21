-- [[ Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- [[ User commands ]]
-- options {} argument required, but left empty here
-- insert ISO date (still puts it on new line)
vim.api.nvim_create_user_command("IsoDate", "pu=strftime('%Y-%m-%dT%H:%M:%S%z')", {})

vim.api.nvim_create_user_command("ChLsp", "checkhealth vim.lsp", {})
