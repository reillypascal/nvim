-- https://neovim.io/doc/user/tabpage.html#setting-tabline
local function filename()
	local fname = vim.fn.expand("%:t")
	if fname == "" then
		return ""
	end
	return fname
end

vim.o.showtabline = 1
vim.o.tabline = filename()
