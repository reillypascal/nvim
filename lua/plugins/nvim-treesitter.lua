---@module 'lazy'
---@type LazySpec
return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	-- main = "nvim-treesitter.configs", -- Sets main module to use for opts; previously macOS not yet using .config
	-- https://github.com/nvim-lua/kickstart.nvim/pull/1748/files
	-- referenced in https://www.reddit.com/r/neovim/comments/1q2rnnl/i_just_installed_kickstart_and_getting_this_error/
	main = "nvim-treesitter.config",
	-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
	config = function()
		require("nvim-treesitter").setup({
			opts = {
				ensure_installed = {
					"bash",
					"c",
					"cmake",
					"cpp",
					"css",
					"diff",
					"faust",
					"haskell",
					"html",
					"javascript",
					"json",
					"json5",
					"latex",
					"liquid",
					"lua",
					"luadoc",
					"make",
					"markdown",
					"markdown_inline",
					"python",
					"rust",
					"scheme",
					"supercollider",
					"toml",
					-- "vimdoc",
					"xml",
					"yaml",
					"zsh",
				},
				-- Autoinstall languages that are not installed
				auto_install = true,
				highlight = {
					enable = true,
					-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
					--  If you are experiencing weird indenting issues, add the language to
					--  the list of additional_vim_regex_highlighting and disabled languages for indent.
					additional_vim_regex_highlighting = { "ruby" },
				},
				indent = { enable = true, disable = { "ruby" } },
			},
		})

		-- https://www.reddit.com/r/neovim/comments/1l3z4j4/help_with_new_treesitter_setup_in_neovim_default/
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("EnableTreesitterHighlighting", { clear = true }),
			desc = "Try to enable tree-sitter syntax highlighting",
			pattern = "*", -- run on *all* filetypes
			callback = function()
				pcall(function()
					vim.treesitter.start()
				end)
			end,
		})
	end,
	-- There are additional nvim-treesitter modules that you can use to interact
	-- with nvim-treesitter. You should go explore a few and see what interests you:
	--
	--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
	--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
	--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
}
