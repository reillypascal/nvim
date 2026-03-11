return {
	"davidgranstrom/scnvim",
	ft = "supercollider",
	dependencies = { "davidgranstrom/scnvim-tmux" },
	config = function()
		local scnvim = require("scnvim")
		local map = scnvim.map
		local map_expr = scnvim.map_expr

		scnvim.setup({
			keymaps = {
				["<localleader>ee"] = map("editor.send_line", { "i", "n" }, { buffer = true }),
				["<localleader>er"] = {
					map("editor.send_block", { "i", "n" }, { buffer = true }),
					map("editor.send_selection", "x", { buffer = true }),
				},
				["<localleader>spt"] = map("postwin.toggle", { buffer = true }),
				["<localleader>spc"] = map("postwin.clear", { "n", "i" }, { buffer = true }),
				["<localleader>si"] = map("signature.show", { "n", "i" }, { buffer = true }),
				["<localleader>s."] = map("sclang.hard_stop", { "n", "x", "i" }, { buffer = true }),
				["<localleader>ss"] = map("sclang.start", { "n", "x", "i" }, { buffer = true }),
				["<localleader>sr"] = map("sclang.recompile", { "n", "x", "i" }, { buffer = true }),
				["<localleader>sb"] = map_expr("s.boot", { "n", "x", "i" }, { buffer = true }),
				["<localleader>sk"] = map_expr("Server.killAll", { "n", "x", "i" }, { buffer = true }),
				["<localleader>sq"] = map_expr("s.quit", { "n", "x", "i" }, { buffer = true }),
				["<localleader>sm"] = map_expr("s.meter", { "n", "x", "i" }, { buffer = true }),
				["<localleader>so"] = map_expr("s.scope", { "n", "x", "i" }, { buffer = true }),
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
					enabled = true,
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
