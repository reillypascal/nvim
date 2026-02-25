return {
	"Olical/conjure",
	config = function()
		-- default: { "clojure", "elixir", "fennel", "janet", "hy", "julia", "racket", "scheme", "lua", "lisp", "python", "ruby", "rust", "sql" }
		vim.g["conjure#filetypes"] = { "lisp", "scheme" }
		vim.g["conjure#log#wrap"] = true
		vim.g["conjure#log#hud#enabled"] = false
		-- guile
		-- https://github.com/Olical/conjure/wiki/Quick-start:-Guile-(socket)
		-- vim.g["conjure#filetype#scheme"] = "conjure.client.guile.socket"
		-- vim.g["conjure#client#guile#socket#pipename"] = ".guile-repl.socket"
		-- lilypond scheme sandbox
		-- https://github.com/Olical/conjure/wiki/Quick-start:-Scheme-(stdio)
		vim.g["conjure#client#scheme#stdio#command"] = "lilypond scheme-sandbox"
		vim.g["conjure#client#scheme#stdio#prompt_pattern"] = "scheme@(.*)> "
	end,
}
