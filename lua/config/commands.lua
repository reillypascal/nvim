-- [[ Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("rs-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- [[ User commands ]]
-- options {} argument required, but left empty here
-- insert ISO date: https://vi.stackexchange.com/a/21826
vim.api.nvim_create_user_command("IsoDate", [[execute "normal! a" .. strftime('%Y-%m-%dT%H:%M:%S%z') .. "\<Esc>"]], {})

-- shorter alias to check lsp health
vim.api.nvim_create_user_command("ChLsp", "checkhealth vim.lsp", {})

-- turn off spellcheck in terminal buffers
vim.cmd([[au TermOpen * setlocal nospell]], false)
