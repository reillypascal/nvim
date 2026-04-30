-- [[ LSP config ]]

local lsp_configs = {}

-- return path if notes dir
-- return nil if not
local is_notes_dir = function()
	local root_markers = { ".obsidian", ".moxide.toml", ".zk" }
	return vim.fs.root(0, root_markers)
end

for _, f in pairs(vim.api.nvim_get_runtime_file("lsp/*.lua", true)) do
	local server_name = vim.fn.fnamemodify(f, ":t:r")
	if server_name == "marksman" and is_notes_dir() ~= nil then
		-- if obsidian root is in cwd/ancestor, don't also use marksman
		-- this avoids "A" on grO
	elseif server_name == "markdown_oxide" and is_notes_dir() == nil then
		-- don't use moxide if not notes dir.
	else
		table.insert(lsp_configs, server_name)
	end
end

vim.lsp.enable(lsp_configs)

-- [[ LSP diagnostic config ]]
-- for gutter, not statusline
-- See :help vim.diagnostic.Opts
vim.diagnostic.config({
	severity_sort = true,
	float = {
		-- border = "rounded",
		source = true,
		show_header = false,
		-- format = function(diagnostic)
		-- 	return string.format("%s\n%s: %s", diagnostic.message, diagnostic.source, diagnostic.code)
		-- end,
	},
	-- this line is what's muting diagnostics
	virtual_text = false,
	-- this line inserts extra blank line for diagnostics
	-- virtual_lines = {
	-- 	current_line = true,
	-- },
	underline = { severity = vim.diagnostic.severity.ERROR },
	signs = vim.g.have_nerd_font and {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
	} or {},
})
