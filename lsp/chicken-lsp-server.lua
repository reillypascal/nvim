---@type vim.lsp.Config
return {
  cmd = { "chicken-lsp-server" },
  filetypes = { 'scheme' },
  root_markers = {
	  ".git"
  },
}
