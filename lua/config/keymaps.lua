-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set("n", "<leader>ld", vim.diagnostic.setloclist, { desc = "Add all [d]iagnostics to the location list." })
vim.keymap.set("n", "<leader>cd", vim.diagnostic.setqflist, { desc = "Add all [d]iagnostics to the quickfix list." })

-- vim.keymap.set("n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "LSP: [g]o to [d]efinition" })
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "LSP: [g]o to [d]efinition" })
vim.keymap.set(
	"n",
	-- "<leader>gi",
	"gi",
	"<cmd>lua vim.lsp.buf.implementation()<CR>",
	{ desc = "LSP: [g]o to [i]mplementation" }
)

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- Close floating windows
-- https://www.reddit.com/r/neovim/comments/1335pfc/comment/jwl13zy/
vim.keymap.set("n", "<esc>", function()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_get_config(win).relative == "win" then
			vim.api.nvim_win_close(win, false)
		end
	end
end)

-- Close floating windows if not focused - currently gives error!
-- https://www.reddit.com/r/neovim/comments/1335pfc/comment/jiaagyi/
-- vim.keymap.set("n", "<esc>", function()
-- 	local inactive_floating_wins = vim.fn.filter(vim.api.nvim_list_wins(), function(_, v)
-- 		return vim.api.nvim_win_get_config(v).relative ~= "" and v ~= vim.api.nvim_get_current_win()
-- 	end)
-- 	for _, w in ipairs(inactive_floating_wins) do
-- 		pcall(vim.api.nvim_win_close, w, false)
-- 	end
-- end)

-- Diagnostic keybinds to replace tiny-inline-diagnostic
-- https://www.reddit.com/r/neovim/comments/megnhx/comment/gshmeik/
-- vim.keymap.set("n", "<leader>]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<leader>[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<leader>wd", "<cmd> lua vim.diagnostic.open_float()<CR>", { silent = true, noremap = true })
