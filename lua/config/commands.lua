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

-- macOS doesn't send capslock to terminal as keypress (?)
-- vim.api.nvim_create_autocmd("VimEnter", {
-- 	desc = "Remap caps lock to escape",
-- 	group = vim.api.nvim_create_augroup("capslock-maps", { clear = true }),
-- 	callback = function()
-- 		vim.cmd("!setxkbmap -option caps:swapescape")
-- 	end,
-- })
--
-- vim.api.nvim_create_autocmd("VimLeave", {
-- 	group = vim.api.nvim_create_augroup("capslock-maps", { clear = true }),
-- 	callback = function()
-- 		vim.cmd("!setxkbmap -option")
-- 	end,
-- })

-- [[ User commands ]]
-- options {} argument required, but left empty here
-- insert ISO date: https://vi.stackexchange.com/a/21826
vim.api.nvim_create_user_command("IsoDate", [[execute "normal! a" .. strftime('%Y-%m-%dT%H:%M:%S%z') .. "\<Esc>"]], {})

vim.api.nvim_create_user_command("ChLsp", "checkhealth vim.lsp", {})
