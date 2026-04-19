---@module 'lazy'
---@type LazySpec
return {
	"martineausimon/nvim-lilypond-suite",
	ft = { "lilypond", "latex", "texinfo" },
	-- https://github.com/martineausimon/nvim-lilypond-suite/wiki/2.-Configuration#customize-default-settings
	opts = {
		lilypond = {
			options = {
				pitches_language = "english",
			},
		},
	},
}
