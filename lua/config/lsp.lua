local lsp_configs = {}

for _, f in pairs(vim.api.nvim_get_runtime_file("lsp/*.lua", true)) do
	local server_name = vim.fn.fnamemodify(f, ":t:r")
	table.insert(lsp_configs, server_name)
end

vim.lsp.enable(lsp_configs)

-- local function setup_lsp()
-- 	local lsp_dir = vim.fn.stdpath("config") .. "/lsp"
-- 	local lsp_servers = {}
--
-- 	if vim.fn.isdirectory(lsp_dir) == 1 then
-- 		for _, file in ipairs(vim.fn.readdir(lsp_dir)) do
-- 			if file:match("%.lua$") and file ~= "init.lua" then
-- 				local server_name = file:gsub("%.lua$", "")
-- 				table.insert(lsp_servers, server_name)
-- 			end
-- 		end
-- 	end
--
-- 	vim.lsp.enable(lsp_servers)
-- end
