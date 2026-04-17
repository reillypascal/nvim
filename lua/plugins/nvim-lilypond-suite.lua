---@module 'lazy'
---@type LazySpec
return {
	"martineausimon/nvim-lilypond-suite",
	ft = { "lilypond" },
	opts = {
		lilypond = {
			mappings = {
				player = "<F3>",
				compile = "<F5>",
				open_pdf = "<F6>",
				switch_buffers = "<A-Space>",
				insert_version = "<F4>",
				hyphenation = "<F12>",
				hyphenation_change_lang = "<F11>",
				-- note that <localleader> would interfere with ;/, repeats of f/F/t/T
				insert_hyphen = "<leader>ih",
				add_hyphen = "<leader>ah",
				del_next_hyphen = "<leader>dh",
				del_prev_hyphen = "<leader>dH",
			},
			options = {
				pitches_language = "english",
				hyphenation_language = "en_DEFAULT",
				output = "pdf",
				backend = nil,
				main_file = "main.ly",
				main_folder = "%:p:h",
				include_dir = nil,
				pdf_viewer = nil,
				errors = {
					diagnostics = true,
					quickfix = "external",
					filtered_lines = {
						"compilation successfully completed",
						"search path",
					},
				},
			},
		},
		latex = {
			mappings = {
				compile = "<F5>",
				open_pdf = "<F6>",
				lilypond_syntax = "<F3>",
			},
			options = {
				lilypond_book_flags = nil,
				clean_logs = false,
				main_file = "main.tex",
				main_folder = "%:p:h",
				include_dir = nil,
				lilypond_syntax_au = "BufEnter",
				pdf_viewer = nil,
				errors = {
					diagnostics = true,
					quickfix = "external",
					filtered_lines = {
						"Missing character",
						"LaTeX manual or LaTeX Companion",
						"for immediate help.",
						"Overfull \\hbox",
						"^%s%.%.%.",
						"%s+%(.*%)",
					},
				},
			},
		},
		texinfo = {
			mappings = {
				compile = "<F5>",
				open_pdf = "<F6>",
				lilypond_syntax = "<F3>",
			},
			options = {
				lilypond_book_flags = "--pdf",
				clean_logs = false,
				main_file = "main.texi",
				main_folder = "%:p:h",
				lilypond_syntax_au = "BufEnter",
				pdf_viewer = nil,
				errors = {
					diagnostics = true,
					quickfix = "external",
					filtered_lines = {
						"Missing character",
						"LaTeX manual or LaTeX Companion",
						"for immediate help.",
						"Overfull \\hbox",
						"^%s%.%.%.",
						"%s+%(.*%)",
					},
				},
			},
		},
	},
}
