return {
	"Olical/conjure",
	config = function()
		vim.cmd([[
			" Guile: https://github.com/Olical/conjure/wiki/Quick-start:-Guile-(socket)
			" let g:conjure#filetype#scheme = "conjure.client.guile.socket"
			" let g:conjure#client#guile#socket#pipename = ".guile-repl.socket"
			" Lilypond Scheme Sandbox: https://github.com/Olical/conjure/wiki/Quick-start:-Scheme-(stdio)
			let g:conjure#client#scheme#stdio#command = "lilypond scheme-sandbox"
			let g:conjure#client#scheme#stdio#prompt_pattern = "> "
		]])
	end,
}
