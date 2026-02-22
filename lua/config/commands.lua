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

vim.api.nvim_create_user_command("Jdate", [[execute "normal! a" .. strftime('%A %B %e, %Y') .. "\<Esc>"]], {})

vim.api.nvim_create_user_command("Title", [[execute "normal! a" .. expand("%:t:r") .. "\<Esc>"]], {})

-- shorter alias to check lsp health
vim.api.nvim_create_user_command("ChLsp", "checkhealth vim.lsp", {})

-- toggle spelling
vim.api.nvim_create_user_command("Sp", function()
	vim.o.spelllang = "en_us"
	vim.o.spell = not vim.opt.spell:get()
end, {})

-- turn off spellcheck in terminal buffers
-- https://github.com/neovim/neovim/issues/2862#issuecomment-113536390
--     also turn off list, cursorline, and cursorcolumn?
vim.cmd([[au TermOpen * setlocal nospell]], false)

-- expand `%%` to current file's directory in command mode
-- useful for `:'<,'>w file2` to extract section to new file:
-- put file in same directory as buffer
-- https://www.reddit.com/r/vim/comments/gned4g/comment/fr9oo3c/
vim.cmd([[cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%']])
