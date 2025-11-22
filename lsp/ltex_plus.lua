-- ltex_plus.lua
-- note that ltex_plus is a maintained replacement for ltex
-- config reference: https://github.com/miikanissi/dotfiles/blob/cfe7c149baca373c9109d997cfac3ca1eb0e29e0/.config/nvim/init.lua#L540 and https://miikanissi.com/blog/grammar-and-spell-checker-in-nvim/
local words = {}
for word in io.open(vim.fn.stdpath("config") .. "/spell/en.utf-8.add", "r"):lines() do
	table.insert(words, word)
end

-- -@type vim.lsp.Config
return {
	cmd = { "ltex-ls-plus" },
	-- removed html/xhtml since they seemed to conflict w/ biome
	filetypes = {
		"bib",
		"context",
		-- "gitcommit",
		-- "html",
		"markdown",
		"org",
		"pandoc",
		"plaintex",
		"quarto",
		"mail",
		"mdx",
		"rmd",
		"rnoweb",
		"rst",
		"tex",
		"text",
		"typst",
		-- "xhtml",
	},
	root_markers = { ".git" },
	settings = {
		ltex = {
			language = "en-US",
			enabled = {
				"bib",
				"context",
				-- "gitcommit",
				-- "html",
				"markdown",
				"org",
				"pandoc",
				"plaintex",
				"quarto",
				"mail",
				"mdx",
				"rmd",
				"rnoweb",
				"rst",
				"tex",
				"latex",
				"text",
				"typst",
				-- "xhtml",
			},
			dictionary = {
				["en-US"] = words,
			},
		},
	},
}
