-- enables highlighting, but note that it may cause issues with hls
-- vim.cmd("set ft=haskell")
vim.api.nvim_set_option_value("filetype", "haskell", { buf = 0 }) -- same thing?
