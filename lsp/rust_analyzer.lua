return {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	workspace_required = false,
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
