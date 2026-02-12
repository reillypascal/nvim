local picker = require("fzf-lua")
vim.keymap.set("n", "<leader>sh", picker.helptags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sk", picker.keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>sf", picker.files, { desc = "[S]earch [F]iles" })
-- was <leader>ss
vim.keymap.set("n", "<leader>sb", picker.builtin, { desc = "[S]earch Picker [B]uiltins" })
vim.keymap.set("n", "<leader>sw", picker.grep_cword, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", picker.live_grep, { desc = "[S]earch by [G]rep" })
-- also available: `diagnostics_document`
vim.keymap.set("n", "<leader>sd", picker.diagnostics_workspace, { desc = "[S]earch Workspace [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", picker.resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>s.", picker.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set("n", "<leader><leader>", picker.buffers, { desc = "[ ] Find existing buffers" })
-- my keymaps
-- search keymaps
vim.keymap.set("n", "<leader>so", picker.global, { desc = "[S]earch with gl[o]bal search" })
vim.keymap.set("n", "<leader>/", picker.blines, { desc = "Search [/] current buffer lines" })
-- quickfix/loclist
vim.keymap.set("n", "<leader>sc", picker.quickfix, { desc = "[S]earch [Q]uickfix list" })
vim.keymap.set("n", "<leader>sl", picker.loclist, { desc = "[S]earch [L]oclist" })
-- misc keymaps
vim.keymap.set("n", "<leader>sm", picker.marks, { desc = "[S]earch [M]arks" })
vim.keymap.set("n", "<leader>z", picker.zoxide, { desc = "[Z]oxide" })
-- git keymaps
vim.keymap.set("n", "<leader>gf", picker.git_files, { desc = "[G]it [F]iles" })
vim.keymap.set("n", "<leader>gs", picker.git_status, { desc = "[G]it [S]tatus" })
vim.keymap.set("n", "<leader>gd", picker.git_diff, { desc = "[G]it [D]iff" })
vim.keymap.set("n", "<leader>gd", picker.git_hunks, { desc = "[G]it [H]unks" })

-- was for Obsidian - see plugin setup file for replacement
-- vim.keymap.set("n", "<leader>ss", builtin.lsp_document_symbols, { desc = "[S]earch LSP Document [S]ymbols" })

-- Slightly advanced example of overriding default behavior and theme
-- vim.keymap.set("n", "<leader>/", function()
-- 	-- You can pass additional configuration to Telescope to change the theme, layout, etc.
-- 	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
-- 		winblend = 10,
-- 		previewer = false,
-- 	}))
-- end, { desc = "[/] Fuzzily search in current buffer" })

-- It's also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
-- vim.keymap.set("n", "<leader>s/", function()
-- 	builtin.live_grep({
-- 		grep_open_files = true,
-- 		prompt_title = "Live Grep in Open Files",
-- 	})
-- end, { desc = "[S]earch [/] in Open Files" })

-- Shortcut for searching your Neovim configuration files
-- vim.keymap.set("n", "<leader>sn", function()
-- 	builtin.find_files({ cwd = vim.fn.stdpath("config") })
-- end, { desc = "[S]earch [N]eovim files" })
