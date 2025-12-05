-- https://nuxsh.is-a.dev/blog/custom-nvim-statusline.html
-- https://elianiva.my.id/posts/neovim-lua-statusline/

-- local modes = {
-- 	["n"] = "N",
-- 	["no"] = "N•P",
-- 	["v"] = "V",
-- 	["V"] = "V•L",
-- 	[""] = "V•B",
-- 	["s"] = "S",
-- 	["S"] = "S•L",
-- 	[""] = "S•B",
-- 	["i"] = "I",
-- 	["ic"] = "I",
-- 	["R"] = "R",
-- 	["Rv"] = "V•R",
-- 	["c"] = "C",
-- 	["cv"] = "V•E",
-- 	["ce"] = "E",
-- 	["r"] = "P",
-- 	["rm"] = "M",
-- 	["r?"] = "C",
-- 	["!"] = "S",
-- 	["t"] = "T",
-- }

local modes = {
	["n"] = "NORMAL",
	["no"] = "NORMAL",
	["v"] = "VISUAL",
	["V"] = "VISUAL LINE",
	[""] = "VISUAL BLOCK",
	["s"] = "SELECT",
	["S"] = "SELECT LINE",
	[""] = "SELECT BLOCK",
	["i"] = "INSERT",
	["ic"] = "INSERT",
	["R"] = "REPLACE",
	["Rv"] = "VISUAL REPLACE",
	["c"] = "COMMAND",
	["cv"] = "VIM EX",
	["ce"] = "EX",
	["r"] = "PROMPT",
	["rm"] = "MORE",
	["r?"] = "CONFIRM",
	["!"] = "SHELL",
	["t"] = "TERMINAL",
}

local function mode()
	local current_mode = vim.api.nvim_get_mode().mode
	return string.format(" %s ", modes[current_mode]):upper()
end

local vcs = function()
	local git_info = vim.b.gitsigns_status_dict
	if not git_info or git_info.head == "" then
		return ""
	end
	local added = git_info.added and (" %#GitSignsAdd#+" .. git_info.added) or ""
	local changed = git_info.changed and (" %#GitSignsChange#~" .. git_info.changed) or ""
	local removed = git_info.removed and (" %#GitSignsDelete#-" .. git_info.removed) or ""
	if git_info.added == 0 then
		added = ""
	end
	if git_info.changed == 0 then
		changed = ""
	end
	if git_info.removed == 0 then
		removed = ""
	end
	return table.concat({
		" %#GitSignsAdd# ",
		git_info.head,
		" ",
		added,
		changed,
		removed,
		"%#StatusLine#",
	})
end

local function lsp()
	local count = {}
	local levels = {
		errors = "Error",
		warnings = "Warn",
		info = "Info",
		hints = "Hint",
	}

	local errors = ""
	local warnings = ""
	local hints = ""
	local info = ""

	for k, level in pairs(levels) do
		count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
	end

	if count["errors"] ~= 0 then
		errors = " %#LspDiagnosticsSignError#󰅚 " .. count["errors"]
	end
	if count["warnings"] ~= 0 then
		warnings = " %#LspDiagnosticsSignWarning#󰀪 " .. count["warnings"]
	end
	if count["hints"] ~= 0 then
		hints = " %#LspDiagnosticsSignHint#󰋽 " .. count["hints"]
	end
	if count["info"] ~= 0 then
		info = " %#LspDiagnosticsSignInformation#󰌶 " .. count["info"]
	end

	return " " .. errors .. warnings .. hints .. info .. " "
end

local function filepath()
	local fpath = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.:h")
	if fpath == "" or fpath == "." then
		return " "
	end

	return string.format(" %%<%s/", fpath)
end

local function filename()
	local fname = vim.fn.expand("%:t")
	if fname == "" then
		return ""
	end
	return fname .. " "
end

local function filetype()
	return string.format(" %s ", vim.bo.filetype) --:upper()
end

local function eol()
	local formats = {
		dos = "crlf",
		unix = "lf",
		mac = "cr",
	}
	return string.format(" %s ", formats[vim.bo.fileformat])
	-- return string.format(" %s ", vim.bo.fileformat)
end

local function lineinfo()
	if vim.bo.filetype == "alpha" then
		return ""
	end
	return " %l:%c " .. " %P "
end

Statusline = {}

Statusline.active = function()
	return table.concat({
		"%#Statusline#",
		-- update_mode_colors(),
		mode(),
		vcs(),
		lsp(),
		filepath(),
		filename(),
		"%=%#StatusLineExtra#",
		filetype(),
		eol(),
		lineinfo(),
	})
end

function Statusline.inactive()
	return " %F"
end

function Statusline.short()
	return "%#StatusLineNC#   NvimTree"
end

vim.cmd(
	[[
augroup Statusline
	au!
	au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
	au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
	au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short()
	augroup END
	]],
	false
)
