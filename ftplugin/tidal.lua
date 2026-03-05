-- open GHCI REPL in term split using Tidal boot file
vim.keymap.set(
	"n",
	"<localleader>b",
	"<cmd>10 split term://ghci -ghci-script=$TIDAL_BOOT_PATH/BootTidal.hs %<cr>:startinsert<cr>",
	{ desc = "Boot Tidal server and open in terminal split", noremap = true, buffer = true }
)
-- yank current line; move to term; paste, enter append mode, <CR>; back to normal mode; return to previous location
vim.keymap.set(
	"n",
	"<localleader>ee",
	[[ yy<C-w>jpa<CR><C-\><C-n><C-w>p ]],
	{ desc = "Evaluate current line", noremap = true, buffer = true }
)
-- yank current block to "*; wrap in :{/:}; move to term; paste from "*, enter append mode, <CR>; back to normal mode; return to previous location
vim.keymap.set(
	"n",
	"<localleader>er",
	[[ "*yip <cmd>let @* = "\:\{\n" . @* . "\:\}"<cr> <C-w>j"*pa<CR><C-\><C-n><C-w>p ]],
	{ desc = "Evaluate current block", noremap = true, buffer = true }
)
-- 'hush' message
vim.keymap.set(
	"n",
	"<localleader>.",
	[[ <C-w>jahush<CR><C-\><C-n><C-w>p ]],
	{ desc = "Send message 'hush' to Tidal interpreter", noremap = true, buffer = true }
)
-- enables highlighting, but note that it may cause issues with hls
vim.cmd("set ft=haskell")
-- vim.api.nvim_set_option_value("filetype", "haskell", { buf = 0 }) -- same thing?
