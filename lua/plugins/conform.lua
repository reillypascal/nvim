return { -- Autoformat
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		notify_on_error = false,
		format_on_save = function(bufnr)
			-- Disable "format_on_save lsp_fallback" for languages that don't
			-- have a well standardized coding style. You can add additional
			-- languages here or re-enable it for the disabled ones.
			local disable_filetypes = { c = true, cpp = true }
			if disable_filetypes[vim.bo[bufnr].filetype] then
				return nil
			else
				return {
					timeout_ms = 500,
					lsp_format = "fallback",
				}
			end
		end,
		formatters_by_ft = {
			-- Conform can also run multiple formatters sequentially
			--
			-- You can use 'stop_after_first' to run the first available formatter from the list
			-- javascript = { "prettierd", "prettier", stop_after_first = true },
			bash = { "shfmt" },
			c = { "clang-format" },
			cmake = { "gersemi" },
			cpp = { "clang-format" },
			css = { "biome" },
			haskell = { "ormolu" },
			html = { "biome" },
			javascript = { "biome" },
			json = { "biome" },
			-- https://shopify.dev/docs/storefronts/themes/tools/liquid-prettier-plugin
			liquid = { "prettierd" },
			lua = { "stylua" },
			-- markdown = { "prettierd" },
			markdown = { "rumdl_fmt" },
			nunjucks = { "prettierd" },
			python = { "ruff" },
			rust = { "rustfmt" },
			sh = { "shfmt" },
			tidal = { "ormolu" },
			toml = { "tombi" },
			zig = { "zigfmt" },
			zsh = { "shfmt" },
		},
		-- https://github.com/stevearc/conform.nvim/issues/814#issuecomment-3599483608
		formatters = {
			rumdl_fmt = {
				command = "rumdl",
				args = { "fmt", "-", "--quiet" },
				stdin = true,
			},
		},
	},
}
