return {
	"mason-org/mason.nvim",
	opts = {
		ensure_installed = {
			-- "basedpyright",
			-- "bash-language-server",
			-- "biome", -- web/JS linting/formatting
			-- "clang-format",
			-- "clangd",
			"codelldb",
			"cpptools",
			"cssls",
			-- "curlylint",
			--"gopls",
			-- "haskell-language-server",
			-- note this takes a *long* time to install!
			-- "haskell-debug-adapter",
			-- 'js-debug-adapter',
			"json-lsp",
			-- "ltex-ls-plus",
			-- "lua-language-server",
			-- "marksman",
			-- "ormolu",
			-- "prettierd",
			-- 'pyrefly', -- python; basedpyright replacement? in rust
			-- "ruff",
			-- DON'T install rust-analyzer via Mason; ends up running twice
			-- "rust_analyzer",
			-- "stylelint", -- outdated; using biome
			-- "stylua", -- Used to format Lua code
			-- "tombi", -- TOML - new, but seems nicer than taplo
			-- 'typescript-language-server',
			-- 'ty', -- python: replacement for basedpyright; same people as ruff; alpha but promising
			-- people on Reddit say vtsls is better than ts_ls
			"vtsls",
			-- "yaml-language-server",
		},
	},
	-- also see  mason-lspconfig.nvim, mason-tool-installer.nvim
}
