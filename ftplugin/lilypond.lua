require("config.visual-lines")

-- use spaces, not tabs
vim.cmd("set expandtab")

-- wrap at space between words — relevant for frontmatter text, among other things
vim.opt.linebreak = true

-- allows comment.nvim to insert in Lilypond
-- note space: ensures space between comment symbol and code
-- https://github.com/numtostr/comment.nvim?tab=readme-ov-file#%EF%B8%8F-filetypes--languages
vim.bo.commentstring = "% %s"
