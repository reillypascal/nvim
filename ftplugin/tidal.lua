-- allows using Haskell Tree-Sitter parser without reassigning language
vim.treesitter.language.register("haskell", "tidal")
-- :InspectTree works after prev. line, but need this for highlighting
vim.treesitter.start(0, "haskell")

-- this way of getting highlighting causes issues with hls
-- vim.cmd("set ft=haskell") -- OR
-- vim.api.nvim_set_option_value("filetype", "haskell", { buf = 0 })
