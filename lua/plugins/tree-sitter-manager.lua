return {
	"romus204/tree-sitter-manager.nvim",
	dependencies = {}, -- tree-sitter CLI must be installed system-wide
	config = function()
		require("tree-sitter-manager").setup({
			-- list of parsers to install automatically
			ensure_installed = {
				-- nvim includes these by default: C, Lua, Markdown, Vimscript, Vimdoc, Treesitter query files
				-- https://neovim.io/doc/user/treesitter/#treesitter-parsers
				"bash",
				"cmake",
				"cpp",
				"css",
				"haskell",
				"html",
				"javascript",
				"json",
				"latex",
				"liquid",
				"make",
				"python",
				"rust",
				"scheme",
				"sql",
				"supercollider",
				"toml",
				"xml",
				"yaml",
				"zsh",
			},
			languages = {
				genexpr = {
					install_info = {
						url = "https://github.com/isabelgk/tree-sitter-genexpr",
						use_repo_queries = true, -- copy queries/ from the cloned repo
					},
				},
			},
			-- Optional: custom paths
			-- parser_dir = vim.fn.stdpath("data") .. "/site/parser",
			-- query_dir = vim.fn.stdpath("data") .. "/site/queries",
		})
	end,
}
