require("config.statusline")
require("config.options")
require("config.keymaps")
require("config.commands")
require("config.lsp")
-- require("config.lsp.commands-fzf-lua")
require("config.lsp.commands-telescope")
require("config.plugins")
-- telescope equivalent is in telescope.lua plugin file
-- require("config.keymaps-fzf-lua")

require("nvim-highlight-colors").turnOff()
--[[
:HighlightColors On 	Turn highlights on
:HighlightColors Off 	Turn highlights off
:HighlightColors Toggle 	Toggle highlights
:HighlightColors IsActive 	Highlights active / disabled
]]
--
