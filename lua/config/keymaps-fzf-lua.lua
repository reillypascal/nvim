local picker = require("fzf-lua")
vim.keymap.set("n", "<leader>sh", picker.helptags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sk", picker.keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>sf", picker.files, { desc = "[S]earch [F]iles" })
-- was <leader>ss
vim.keymap.set("n", "<leader>sb", picker.builtin, { desc = "[S]earch fzf-lua [B]uiltins" })
-- vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", picker.live_grep, { desc = "[S]earch by [G]rep" })
-- vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", picker.resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>s.", picker.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set("n", "<leader><leader>", picker.buffers, { desc = "[ ] Find existing buffers" })
-- my keymaps
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
