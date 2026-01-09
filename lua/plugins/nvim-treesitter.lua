-- this is only necessary because macOS/Arch need different values as of 2026-01-08
-- https://github.com/nvim-lua/kickstart.nvim/pull/1748/files
--	referenced in https://www.reddit.com/r/neovim/comments/1q2rnnl/i_just_installed_kickstart_and_getting_this_error/
local os_name = vim.loop.os_uname().sysname

if os_name == "Linux" then
	Main_module = "nvim-treesitter.config"
else
	Main_module = "nvim-treesitter.configs"
end

return { -- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	-- only need main as variable since macOS not yet using "config" instead of "configs"
	-- main = "nvim-treesitter.configs", -- Sets main module to use for opts
	main = Main_module,
	-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
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
			"query",
			"regex",
			"rust",
			"supercollider",
			"toml",
			"vim",
			"vimdoc",
			"xml",
			"yaml",
		},
		-- Autoinstall languages that are not installed
		auto_install = false,
		highlight = {
			enable = true,
			-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
			--  If you are experiencing weird indenting issues, add the language to
			--  the list of additional_vim_regex_highlighting and disabled languages for indent.
			additional_vim_regex_highlighting = { "ruby" },
		},
		indent = { enable = true, disable = { "ruby" } },
	},
	-- There are additional nvim-treesitter modules that you can use to interact
	-- with nvim-treesitter. You should go explore a few and see what interests you:
	--
	--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
	--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
	--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
}
