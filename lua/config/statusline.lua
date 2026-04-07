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

	-- BUG: appears before added/changed/removed displays
	local end_padding = ""
	if git_info.added ~= 0 or git_info.changed ~= 0 or git_info.removed ~= 0 then
		end_padding = " "
	end

	return table.concat({
		" %#StatusLine# ",
		git_info.head,
		" ",
		added,
		changed,
		removed,
		end_padding,
		"%#StatusLine#",
	})
end

local function lsp_diag()
	local count = {}
	local levels = {
		errors = vim.diagnostic.severity.ERROR,
		warnings = vim.diagnostic.severity.WARN,
		info = vim.diagnostic.severity.INFO,
		hints = vim.diagnostic.severity.HINT,
	}

	local errors = ""
	local warnings = ""
	local hints = ""
	local info = ""

	for k, level in pairs(levels) do
		count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
	end

	if count["errors"] ~= 0 then
		errors = " %#LspDiagnosticsDefaultError#󰅚 " .. count["errors"]
	end
	if count["warnings"] ~= 0 then
		warnings = " %#LspDiagnosticsDefaultWarning#󰀪 " .. count["warnings"]
	end
	if count["hints"] ~= 0 then
		hints = " %#LspDiagnosticsDefaultHint#󰌶 " .. count["hints"]
	end
	if count["info"] ~= 0 then
		info = " %#LspDiagnosticsDefaultInformation#󰋽 " .. count["info"]
	end

	if errors == "" and warnings == "" and hints == "" and info == "" then
		return ""
	end

	return errors .. warnings .. hints .. info .. " "
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
	return string.format(" %s ", vim.bo.filetype)
end

local function wordcount()
	if vim.bo.filetype == "markdown" then
		return tostring(" " .. vim.fn.wordcount().words) .. " words "
	else
		return ""
	end
end

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
end

local function lineinfo()
	if vim.bo.filetype == "alpha" then
		return ""
	end
	return " %P " .. " %l:%c "
end

Statusline = {}

Statusline.active = function()
	return table.concat({
		"%#Statusline#",
		mode(),
		vcs(),
		lsp_diag(),
		"%#Statusline#",
		-- don't want to put this in filename(); keep compatibility w/ filepath()
		-- " ",
		filepath(),
		filename(),
		"%=%#StatusLineExtra#",
		filetype(),
		wordcount(),
		encoding(),
		eol(),
		lineinfo(),
	})
end

-- https://www.reddit.com/r/neovim/comments/17hbep3/comment/k6mrasn/
-- https://vi.stackexchange.com/questions/42003/what-does-vlua-mean-in-an-option
vim.o.statusline = "%{%v:lua.Statusline.active()%}"
-- :h ruler - position info (redundant bc in statusline)
-- :h showcmd - current key command; can turn off on slower computers
vim.o.ruler = false
