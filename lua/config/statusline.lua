-- https://nuxsh.is-a.dev/blog/custom-nvim-statusline.html
-- https://elianiva.my.id/posts/neovim-lua-statusline/

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

local function vcs()
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

local function lsp_diag()
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
		-- errors = " %#LspDiagnosticsSignError#󰅚 " .. count["errors"]
		errors = " %#LspDiagnosticsDefaultError#󰅚 " .. count["errors"]
	end
	if count["warnings"] ~= 0 then
		-- warnings = " %#LspDiagnosticsSignWarning#󰀪 " .. count["warnings"]
		warnings = " %#LspDiagnosticsDefaultWarning#󰀪 " .. count["warnings"]
	end
	if count["hints"] ~= 0 then
		-- hints = " %#LspDiagnosticsSignHint#󰌶 " .. count["hints"]
		hints = " %#LspDiagnosticsDefaultHint#󰌶 " .. count["hints"]
	end
	if count["info"] ~= 0 then
		-- info = " %#LspDiagnosticsSignInformation#󰋽 " .. count["info"]
		info = " %#LspDiagnosticsDefaultInformation#󰋽 " .. count["info"]
	end

	if errors == "" and warnings == "" and hints == "" and info == "" then
		return ""
	end

	return " " .. errors .. warnings .. hints .. info .. " "
end

local function lsp()
	local clients = vim.lsp.get_clients()
	-- https://stackoverflow.com/a/1407187
	local client_names = {}
	for _, v in ipairs(clients) do
		client_names[#client_names + 1] = tostring(v.name)
	end

	local client_str = string.format("%s", table.concat(client_names, ", "))

	if client_str == "" then
		return ""
	end

	return " " .. client_str .. " "
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
	return " " .. fname .. " "
end

local function filetype()
	return string.format(" %s ", vim.bo.filetype) --:upper()
end

-- local function tabstop()
-- 	return string.format(" ts=%s ", vim.bo.tabstop)
-- end

local function encoding()
	return string.format(" %s ", vim.bo.fileencoding)
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
		-- "%#LineNr#",
		-- "|",
		-- "%#Statusline#",
		vcs(),
		lsp_diag(),
		"%#Statusline#",
		-- lsp(),
		-- filepath(),
		filename(),
		"%=%#StatusLineExtra#",
		filetype(),
		encoding(),
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
