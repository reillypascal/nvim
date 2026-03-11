return {
	"davidgranstrom/scnvim",
	ft = "supercollider",
	lazy = true,
	dependencies = { "davidgranstrom/scnvim-tmux" },
	config = function()
		local scnvim = require("scnvim")
		local map = scnvim.map
		local map_expr = scnvim.map_expr

		scnvim.setup({
			keymaps = {
				["<S-CR>"] = map("editor.send_line", { "i", "n" }, { buffer = true }),
				["<C-CR>"] = {
					map("editor.send_block", { "i", "n" }, { buffer = true }),
					map("editor.send_selection", "x", { buffer = true }),
				},
				["<CR>"] = map("postwin.toggle", { buffer = true }),
				["<M-CR>"] = map("postwin.toggle", "i", { buffer = true }),
				["<M-L>"] = map("postwin.clear", { "n", "i" }, { buffer = true }),
				["<C-k>"] = map("signature.show", { "n", "i" }, { buffer = true }),
				["<localleader>c."] = map("sclang.hard_stop", { "n", "x", "i" }, { buffer = true }),
				["<localleader>cs"] = map("sclang.start", { "n", "x", "i" }, { buffer = true }),
				["<localleader>cr"] = map("sclang.recompile", { "n", "x", "i" }, { buffer = true }),
				["<localleader>cb"] = map_expr("s.boot", { "n", "x", "i" }, { buffer = true }),
				["<localleader>ck"] = map_expr("Server.killAll", { "n", "x", "i" }, { buffer = true }),
				["<localleader>cq"] = map_expr("s.quit", { "n", "x", "i" }, { buffer = true }),
				["<localleader>cm"] = map_expr("s.meter", { "n", "x", "i" }, { buffer = true }),
				["<localleader>co"] = map_expr("s.scope", { "n", "x", "i" }, { buffer = true }),
			},
			editor = {
				highlight = {
					color = "IncSearch",
				},
			},
			-- this block makes docs appear in nvim; independent of telescope scdoc
			-- documentation = {
			-- 	cmd = "/opt/homebrew/bin/pandoc",
			-- },
			postwin = {
				float = {
					enabled = false,
				},
			},
			extensions = {
				["fzf-sc"] = {
					search_plugin = "nvim-fzf",
				},
				tmux = {
					path = vim.fn.tempname(),
					horizontal = true,
					size = "20%",
					cmd = "tail",
					args = { "-F", "$1" },
				},
			},
		})
	end,
}
