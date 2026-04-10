#!/usr/bin/env bash
# https://github.com/nvim-treesitter/nvim-treesitter/blob/main/lua/nvim-treesitter/parsers.lua
declare -a parsers=(
	"https://github.com/tree-sitter/tree-sitter-bash"
	"https://github.com/uyha/tree-sitter-cmake"
	"https://github.com/tree-sitter/tree-sitter-c"
	"https://github.com/tree-sitter/tree-sitter-cpp"
	"https://github.com/tree-sitter/tree-sitter-css"
	"https://github.com/isabelgk/tree-sitter-genexpr"
	"https://github.com/tree-sitter-grammars/tree-sitter-haskell"
	"https://github.com/tree-sitter/tree-sitter-html"
	"https://github.com/tree-sitter/tree-sitter-javascript"
	"https://github.com/tree-sitter/tree-sitter-json"
	"https://github.com/latex-lsp/tree-sitter-latex"
	"https://github.com/hankthetank27/tree-sitter-liquid"
	"https://github.com/tree-sitter-grammars/tree-sitter-make"
	"https://github.com/tree-sitter/tree-sitter-python"
	"https://github.com/tree-sitter/tree-sitter-rust"
	"https://github.com/6cdh/tree-sitter-scheme"
	"https://github.com/derekstride/tree-sitter-sql"
	"https://github.com/madskjeldgaard/tree-sitter-supercollider"
	"https://github.com/tree-sitter-grammars/tree-sitter-toml"
	"https://github.com/tree-sitter-grammars/tree-sitter-xml"
	"https://github.com/tree-sitter-grammars/tree-sitter-yaml"
	"https://github.com/georgeharker/tree-sitter-zsh"
)
# query only; dependencies for parsers
declare -a queries=(
	"https://github.com/neovim-treesitter/nvim-treesitter-queries-dtd"       # toml
	"https://github.com/neovim-treesitter/nvim-treesitter-queries-ecma"      # javascript
	"https://github.com/neovim-treesitter/nvim-treesitter-queries-html_tags" # html
	"https://github.com/neovim-treesitter/nvim-treesitter-queries-jsx"       # javascript
)

ts_dir="$HOME/.local/share/nvim/site/"
# testing dir:
# ts_dir="$HOME/Downloads/site/"
build_dir="$HOME/Downloads/"
cd "$build_dir" || exit # or return

# clone/pull parsers; build; copy parser and its queries to dir; return to build dir
for parser in "${parsers[@]}"; do
	parser_dir="${parser##*/}"

	query_dir="${parser##*/}"
	query_ft="${parser##*-}"

	if [ -d "$parser_dir" ]; then
		git -C "$parser_dir" pull
	else
		git clone "$parser"
	fi

	cd "$parser_dir" || exit

	# https://tree-sitter.github.io/tree-sitter/cli/generate.html
	# NOTE: generate/build commands are usually silent
	if [ -f "grammar.js" ]; then
		tree-sitter generate "grammar.js"
	elif [ -f "grammar.json" ]; then
		tree-sitter generate "grammar.json"
	else
		return
	fi

	# https://tree-sitter.github.io/tree-sitter/cli/build.html
	tree-sitter build .

	if [[ "$OSTYPE" == "linux-gnu"* ]]; then
		libs="$(find . -type f -name "*.so")"
	elif [[ "$OSTYPE" == "darwin"* ]]; then
		libs="$(find . -type f -name "*.dylib")"
	fi

	mkdir -p "$ts_dir/parsers/"
	mkdir -p "$ts_dir/queries/$query_ft/"

	for lib in ${libs}; do
		cp "$lib" "$ts_dir/parsers/"
	done

	cp -r "queries/." "$ts_dir/queries/$query_ft/"

	cd "$build_dir" || exit
done

# clone/pull queries; copy to dir; return to build dir
for query in "${queries[@]}"; do
	query_dir="${query##*/}"
	query_ft="${query##*-}"

	if [ -d "$query_dir" ]; then
		git -C "$query_dir" pull
	else
		git clone "$query"
	fi

	mkdir -p "$ts_dir/queries/$query_ft/"

	cd "$query_dir" || exit

	cp -r "queries/." "$ts_dir/queries/$query_ft/"

	cd "$build_dir" || exit
done
