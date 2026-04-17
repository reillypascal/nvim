require("config.visual-lines")

-- wrap at space between words
vim.opt.linebreak = true

-- set conceallevel only for note vaults
local dir = vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
if
	string.match(dir, "~/Sync/Notes/*.*")
	or string.match(dir, "~/Sync/Personal/*.*")
	or string.match(dir, "~/Sync (Household)/*.*")
then
	vim.opt.conceallevel = 2
end

-- -- only use spell _outside_ of notes dir, and not in e.g., docs/LSP hover
-- local is_notes_dir = function()
-- 	return vim.fs.root(0, { "obsidian", ".moxide.toml", ".zk" })
-- end
-- if is_notes_dir() == nil and vim.bo.modifiable then
-- 	-- also added ":Sp" command in commands.lua
-- 	vim.opt.spell = true
-- end
