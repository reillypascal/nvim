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

-- https://github.com/LazyVim/LazyVim/issues/6868
-- broke syntax-aware spell-checking
-- vim.api.nvim_create_autocmd("BufEnter", {
-- 	desc = "Turn off spell check for URLs, acronyms, HTML comments",
-- 	group = vim.api.nvim_create_augroup("rs-spell", { clear = true }),
-- 	callback = function()
-- 		-- vim.cmd([=[syn match AcronymNoSpell "\<\(\u\|\d\)\{3,}s\?\>" contains=@NoSpell]=])
-- 		-- vim.cmd([=[syn match HtmlCommentNoSpell '\<!\-\-).*\-\-\>' contains=@NoSpell]=])
-- 		vim.cmd([=[syn match UrlNoSpell "\w\+:\/\/[^[:space:]]\+" contains=@NoSpell]=])
-- 		vim.cmd([[syn spell toplevel]])
-- 	end,
-- })

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
	vim.o.spell = not vim.opt.spell:get()
end, {})

-- turn off spellcheck in terminal buffers
-- https://github.com/neovim/neovim/issues/2862#issuecomment-113536390
--     also turn off list, cursorline, and cursorcolumn?
-- vim.cmd([[au TermOpen * setlocal nospell]], false)

-- expand `%%` to current file's directory in command mode
-- useful for `:'<,'>w file2` to extract section to new file:
-- put file in same directory as buffer
-- https://www.reddit.com/r/vim/comments/gned4g/comment/fr9oo3c/
vim.cmd([[cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%']])

-- paste HTML to Markdown
-- TODO:
-- vim.system
-- local function run_cmd(args, cwd)
--     local opts = { text = true }
--     if cwd then opts.cwd = cwd end
--     local res = vim.system(args, opts):wait()
--     local out = (res.stderr ~= "" and res.stderr) or res.stdout or ""
--     return { ok = res.code == 0, output = out }
-- end

vim.api.nvim_create_user_command("Mdp", function()
	local os_name = vim.loop.os_uname().sysname

	if os_name == "Linux" then
		local class_handle = io.popen([[echo `wl-paste --list-types`]])
		if string.find(class_handle:read(), "text/html") then
			local handle = io.popen(
				[[wl-paste -t text/html | tr -d '\n' | pandoc -f html -t gfm-raw_html --wrap=none | sed 's/ / /g']]
			)
			local result = handle:read("*a")
			vim.api.nvim_paste(result, false, -1)
			handle:close()
		end
		class_handle:close()
	end

	if os_name == "Darwin" then
		-- local class_handle =
		-- 	io.popen([[osascript -e '((clipboard info) as string) contains "«class html»"' | tr -d '\n']])
		-- if class_handle:read("*a") == "true" then
		-- 	local handle = io.popen(
		-- 		[[osascript -e 'the clipboard as «class HTML»' | perl -ne 'print chr foreach unpack("C*",pack("H*",substr($_,11,-3)))' | pandoc -f html -t gfm-raw_html --wrap=none | tr -d '\n']]
		-- 	)
		-- 	local result = handle:read("*a")
		-- 	vim.api.nvim_paste(result, false, -1)
		-- 	handle:close()
		-- end
		-- class_handle:close()

		-- pbpaste-swift: https://stackoverflow.com/a/36109230
		-- note: change branch for no html to just `exit(0)`
		-- tried piping to `perl -pi -e 'chomp if eof'`, but caused statusline duplication glitch
		local handle =
			io.popen([[pbpaste-html | tr -d '\n' | pandoc -f html -t gfm-raw_html --wrap=none | sed 's/ / /g']])
		local result = handle:read("*a")
		if result ~= "\n" then
			vim.api.nvim_paste(result, false, -1)
		end
		handle:close()
	end
end, {})

-- [[ Lilypond ]]
-- https://github.com/martineausimon/nvim-lilypond-suite/wiki/2.-Configuration#recommended-syntax-sync-settings
vim.api.nvim_create_autocmd("BufEnter", {
	command = "syntax sync fromstart",
	pattern = { "*.ly", "*.ily", "*.tex" },
})
