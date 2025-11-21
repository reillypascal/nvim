-- [[ rust_analyzer setup ]]
-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/rust_analyzer.lua
return {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	settings = {
		["rust-analyzer"] = {
			-- diagnostics = {
			-- 	enable = false,
			-- },
			check = {
				command = "clippy",
				extraArgs = { "--no-deps" },
			},
			checkOnSave = true,
			files = {
				watcher = "server",
			},
		},
	},
}
