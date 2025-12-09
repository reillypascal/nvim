vim.opt.linebreak = true

-- set conceallevel only for Obsidian
local dir = vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
if
	string.match(dir, "~/Sync/Notes/*.*")
	or string.match(dir, "~/Sync/Personal/*.*")
	or string.match(dir, "~/Sync (Household)/*.*")
then
	vim.opt.conceallevel = 2
end

vim.opt.spelllang = "en_us"
vim.opt.spell = true

-- Map j and k to move by visual lines
vim.api.nvim_buf_set_keymap(0, "n", "j", "gj", { noremap = true, silent = true })
vim.api.nvim_buf_set_keymap(0, "n", "k", "gk", { noremap = true, silent = true })
vim.api.nvim_buf_set_keymap(0, "v", "j", "gj", { noremap = true, silent = true })
vim.api.nvim_buf_set_keymap(0, "v", "k", "gk", { noremap = true, silent = true })

-- Map $ and 0 to move by visual lines
vim.api.nvim_buf_set_keymap(0, "n", "$", "g$", { noremap = true, silent = true })
vim.api.nvim_buf_set_keymap(0, "n", "0", "g0", { noremap = true, silent = true })
vim.api.nvim_buf_set_keymap(0, "v", "$", "g$", { noremap = true, silent = true })
vim.api.nvim_buf_set_keymap(0, "v", "0", "g0", { noremap = true, silent = true })

-- Map <Down> and <Up> to move by visual lines
vim.api.nvim_buf_set_keymap(0, "n", "<Down>", "g<Down>", { noremap = true, silent = true })
vim.api.nvim_buf_set_keymap(0, "n", "<Up>", "g<Up>", { noremap = true, silent = true })
vim.api.nvim_buf_set_keymap(0, "v", "<Down>", "g<Down>", { noremap = true, silent = true })
vim.api.nvim_buf_set_keymap(0, "v", "<Up>", "g<Up>", { noremap = true, silent = true })

-- Map <Home> and <End> to move by visual lines
vim.api.nvim_buf_set_keymap(0, "n", "<End>", "g<End>", { noremap = true, silent = true })
vim.api.nvim_buf_set_keymap(0, "n", "<Home>", "g<Home>", { noremap = true, silent = true })
vim.api.nvim_buf_set_keymap(0, "v", "<End>", "g<End>", { noremap = true, silent = true })
vim.api.nvim_buf_set_keymap(0, "v", "<Home>", "g<Home>", { noremap = true, silent = true })
