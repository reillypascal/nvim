-- https://neovim.io/doc/user/tabpage.html#setting-tabline
-- https://www.rahuljuliato.com/posts/nvim-tabline (see sect. 4)
local function filename()
	local fname = vim.fn.expand("%:t")
	if fname == "" then
		return ""
	end
	return fname
end

-- vim.o.showtabline = 1

Tabline = {}

Tabline.active = function()
	return table.concat({
		filename(),
	})
end

Tabline.inactive = function()
	return table.concat({
		filename(),
	})
end

vim.cmd(
	[[
augroup Tabline
	au!
	au WinEnter,BufEnter * setlocal tabline=%!v:lua.Tabline.active()
	au WinLeave,BufLeave * setlocal tabline=%!v:lua.Tabline.inactive()
	" au WinEnter,BufEnter,FileType NvimTree setlocal tabline=%!v:lua.Tabline.short()
	augroup END
	]],
	false
)
