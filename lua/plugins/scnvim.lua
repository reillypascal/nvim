return {
	"davidgranstrom/scnvim",
	ft = "supercollider",
	lazy = true,
	-- dependencies = { "davidgranstrom/scnvim-tmux" },
	config = function()
		local scnvim = require("scnvim")
		local map = scnvim.map
		local map_expr = scnvim.map_expr

		scnvim.setup({
			keymaps = {
				["<S-CR>"] = map(
					"editor.send_line",
					{ "i", "n" },
					{ desc = "SuperCollider: send line", buffer = true }
				),
				["<C-CR>"] = {
					map("editor.send_block", { "i", "n" }, { desc = "SuperCollider: send block", buffer = true }),
					map("editor.send_selection", "x", { desc = "SuperCollider: send selection", buffer = true }),
				},
				["<CR>"] = map(
					"postwin.toggle",
					{ "i", "n" },
					{ desc = "SuperCollider: toggle postwin", buffer = true }
				),
				["<localleader>cc"] = map(
					"postwin.clear",
					{ "n", "i" },
					{ desc = "SuperCollider: clear postwin", buffer = true }
				),
				["<localleader>ci"] = map(
					"signature.show",
					{ "n", "i" },
					{ desc = "SuperCollider: show signature", buffer = true }
				),
				["<C-.>"] = map(
					"sclang.hard_stop",
					{ "n", "x", "i" },
					{ desc = "SuperCollider: hard stop", buffer = true }
				),
				["<localleader>cs"] = map(
					"sclang.start",
					{ "n", "x", "i" },
					{ desc = "SuperCollider: start", buffer = true }
				),
				["<localleader>cq"] = map(
					"sclang.stop",
					{ "n", "x", "i" },
					{ desc = "SuperCollider: stop", buffer = true }
				),
				["<localleader>cr"] = map(
					"sclang.recompile",
					{ "n", "x", "i" },
					{ desc = "SuperCollider: recompile class library", buffer = true }
				),
				["<localleader>cb"] = map_expr(
					"s.boot",
					{ "n", "x", "i" },
					{ desc = "SuperCollider: boot server", buffer = true }
				),
				["<localleader>ck"] = map_expr(
					"Server.killAll",
					{ "n", "x", "i" },
					{ desc = "SuperCollider: kill all servers", buffer = true }
				),
				-- ["<localleader>cq"] = map_expr(
				-- 	"s.quit",
				-- 	{ "n", "x", "i" },
				-- 	{ desc = "SuperCollider: quit server", buffer = true }
				-- ),
				["<localleader>cm"] = map_expr(
					"s.meter",
					{ "n", "x", "i" },
					{ desc = "SuperCollider: open meter", buffer = true }
				),
				["<localleader>co"] = map_expr(
					"s.scope",
					{ "n", "x", "i" },
					{ desc = "SuperCollider: open scope", buffer = true }
				),
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
				horizontal = true,
				size = "10",
			},
			extensions = {
				["fzf-sc"] = {
					search_plugin = "nvim-fzf",
				},
				-- tmux = {
				-- 	path = vim.fn.tempname(),
				-- 	horizontal = true,
				-- 	size = "20%",
				-- 	cmd = "tail",
				-- 	args = { "-F", "$1" },
				-- },
			},
		})
	end,
}
