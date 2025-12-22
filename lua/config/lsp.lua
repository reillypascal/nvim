-- [[ LSP config ]]

local lsp_configs = {}

-- return path if moxide dir
-- return nil if not
local is_moxide_dir = function()
	local root_markers = { ".obsidian", ".moxide.toml" }
	return vim.fs.root(0, root_markers)
end

local is_haskell_dir = function()
	-- local extension = vim.fn.expand("%:e")
	local root_markers = { "hie.yaml", "stack.yaml", "cabal.project", "*.cabal", "package.yaml" }
	return vim.fs.root(0, root_markers)
end
-- local tidal_match = vim.filetype.match({ filename = "*.hs" })
-- local extension = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":e")

for _, f in pairs(vim.api.nvim_get_runtime_file("lsp/*.lua", true)) do
	local server_name = vim.fn.fnamemodify(f, ":t:r")
	if server_name == "markdown_oxide" and is_moxide_dir() == nil then
		-- if moxide root not in cwd/ancestor, don't activate moxide
	elseif server_name == "marksman" and is_moxide_dir() ~= nil then
		-- if moxide root _is_ in cwd/ancestor, don't also use marksman
		-- this avoids "A" on gO
	elseif server_name == "codebook" and is_moxide_dir() ~= nil then
		-- also turn off codebook (spellcheck) for notebook - only want it for blog posts
	elseif server_name == "hls" and is_haskell_dir() == nil then
		-- hls gives highlighting error if running with tidal.nvim
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
	virtual_text = false,
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
