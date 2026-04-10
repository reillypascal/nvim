-- allows using Haskell Tree-Sitter parser without reassigning language
vim.treesitter.language.register("haskell", "tidal")
-- :InspectTree works after prev. line, but need this for highlighting
vim.treesitter.start(0, "haskell")
