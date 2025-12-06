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
-- insert ISO date: https://vi.stackexchange.com/a/21826
vim.api.nvim_create_user_command("IsoDate", [[execute "normal! a" .. strftime('%Y-%m-%dT%H:%M:%S%z') .. "\<Esc>"]], {})

vim.api.nvim_create_user_command("ChLsp", "checkhealth vim.lsp", {})
