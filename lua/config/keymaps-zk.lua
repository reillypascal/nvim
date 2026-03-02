-- https://zk-org.github.io/zk/tips/editors-integration.html#custom-commands
vim.keymap.set("n", "<leader>zi", "<cmd>LspZkIndex<CR>", { desc = "[z]k [i]ndex" })
vim.keymap.set("n", "<leader>zl", "<cmd>LspZkList<CR>", { desc = "[z]k [l]ist" })
vim.keymap.set("n", "<leader>zn", "<cmd>LspZkNew<CR>", { desc = "[z]k [n]ew" })
vim.keymap.set("n", "<leader>zt", "<cmd>LspZkTagList<CR>", { desc = "[z]k [t]ag list" })
