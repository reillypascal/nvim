-- [[ LSP config ]]

local lsp_configs = {}

for _, f in pairs(vim.api.nvim_get_runtime_file("lsp/*.lua", true)) do
	local server_name = vim.fn.fnamemodify(f, ":t:r")
	table.insert(lsp_configs, server_name)
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

-- https://www.reddit.com/r/neovim/comments/megnhx/comment/gshk79c/
-- vim.cmd([[autocmd CursorHold * lua vim.diagnostic.open_float()]])
-- in article, but didn't work for me:
-- vim.cmd([[autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()]])
