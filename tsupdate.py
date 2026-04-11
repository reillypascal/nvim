#!/usr/bin/env python3

from argparse import ArgumentParser
from contextlib import chdir
from glob import glob
from os import environ, path, walk
from platform import system
from shutil import copy, copytree
from subprocess import call
from typing import Any, Dict

parser = ArgumentParser()
parser.add_argument(
    "-l",
    "--lang",
    help="Select a single language (and its dependencies) to update",
    type=str,
)
args = parser.parse_args()

# https://stackoverflow.com/a/66731847
parsers: Dict[str, Any] = {
    "bash": {
        "repo": "https://github.com/tree-sitter/tree-sitter-bash",
    },
    "cmake": {"repo": "https://github.com/uyha/tree-sitter-cmake"},
    "cpp": {
        "repo": "https://github.com/tree-sitter/tree-sitter-cpp",
        "parser_deps": ["tree-sitter-c"],
    },
    "css": {"repo": "https://github.com/tree-sitter/tree-sitter-css"},
    "genexpr": {"repo": "https://github.com/isabelgk/tree-sitter-genexpr"},
    "haskell": {"repo": "https://github.com/tree-sitter-grammars/tree-sitter-haskell"},
    "html": {
        "repo": "https://github.com/tree-sitter/tree-sitter-html",
        "query_deps": [
            "https://github.com/neovim-treesitter/nvim-treesitter-queries-html_tags"
        ],
    },
    "javascript": {
        "repo": "https://github.com/tree-sitter/tree-sitter-javascript",
        "query_deps": [
            "https://github.com/neovim-treesitter/nvim-treesitter-queries-ecma",
            "https://github.com/neovim-treesitter/nvim-treesitter-queries-jsx",
        ],
    },
    "json": {"repo": "https://github.com/tree-sitter/tree-sitter-json"},
    "latex": {"repo": "https://github.com/latex-lsp/tree-sitter-latex"},
    "liquid": {"repo": "https://github.com/hankthetank27/tree-sitter-liquid"},
    "make": {"repo": "https://github.com/tree-sitter-grammars/tree-sitter-make"},
    "python": {"repo": "https://github.com/tree-sitter/tree-sitter-python"},
    "rust": {"repo": "https://github.com/tree-sitter/tree-sitter-rust"},
    "scheme": {"repo": "https://github.com/6cdh/tree-sitter-scheme"},
    # missing grammar.json in sql
    # "sql": {"repo": "https://github.com/derekstride/tree-sitter-sql"},
    "supercollider": {
        "repo": "https://github.com/madskjeldgaard/tree-sitter-supercollider"
    },
    "toml": {
        "repo": "https://github.com/tree-sitter-grammars/tree-sitter-toml",
        "query_deps": [
            "https://github.com/neovim-treesitter/nvim-treesitter-queries-dtd"
        ],
    },
    # "xml": {"repo": "https://github.com/tree-sitter-grammars/tree-sitter-xml"},
    "yaml": {"repo": "https://github.com/tree-sitter-grammars/tree-sitter-yaml"},
    "zsh": {"repo": "https://github.com/georgeharker/tree-sitter-zsh"},
}


def update_parser(parser_name, parser_data):
    parser_dir = path.basename(parser_data["repo"])

    if path.exists(parser_dir):
        call(["git", "-C", parser_dir, "pull"])
    else:
        call(["git", "clone", parser_data["repo"]])

    if "parser_deps" in parsers[parser_name]:
        for dep in parsers[parser_name]["parser_deps"]:
            call(["npm", "i", dep])

    # converts to ES modules; issue with yaml
    # with chdir(parser_dir):
    # https://tree-sitter.github.io/tree-sitter/cli/init#-u--update
    # call(["tree-sitter", "init", "-u"])

    # https://tree-sitter.github.io/tree-sitter/cli/generate.html
    # NOTE: generate/build comands are usually silent
    paths_to_search = [
        f"{parser_dir}/grammar.js",
        f"{parser_dir}/grammar.json",
        f"{parser_dir}/src/grammar.js",
        f"{parser_dir}/src/grammar.json",
        f"{parser_dir}/{parser_name}/grammar.js",
        f"{parser_dir}/{parser_name}/grammar.json",
        f"{parser_dir}/{parser_name}/src/grammar.js",
        f"{parser_dir}/{parser_name}/src/grammar.json",
    ]
    did_find_grammar = False
    for candidate in paths_to_search:
        if path.exists(candidate):
            call(["tree-sitter", "generate", candidate])
            did_find_grammar = True
            break

    if did_find_grammar:
        call(["tree-sitter", "build", parser_dir])
        call(["mkdir", "-p", f"{ts_dir}/parsers"])

        if system() == "Darwin":
            for file in glob("*.dylib"):
                copy(file, f"{ts_dir}/parsers/")
        elif system() == "Linux":
            for file in glob("*.so"):
                copy(file, f"{ts_dir}/parsers/")

        if path.exists(f"{parser_dir}/queries"):
            copytree(
                f"{parser_dir}/queries/.",
                f"{ts_dir}/queries/{parser_name}",
                dirs_exist_ok=True,
            )
    else:
        print(f"Could not find grammar for {parser_name}")

    if "query_deps" in parsers[parser_name]:
        for dep in parsers[parser_name]["query_deps"]:
            query_dir = path.basename(dep)
            query_name = dep.rsplit("-", 1)[1]

            if path.exists(query_dir):
                call(["git", "-C", query_dir, "pull"])
            else:
                call(["git", "clone", dep])

            with chdir(query_dir):
                copytree(
                    "queries/.", f"{ts_dir}/queries/{query_name}", dirs_exist_ok=True
                )


ts_dir = f"{environ["HOME"]}/.local/share/nvim/site"
# alternate dir for testing
# ts_dir = f"{environ["HOME"]}/Downloads/site"
build_dir = f"{environ["HOME"]}/Downloads"

# with chdir returns to original path when done
with chdir(build_dir):
    if args.lang:
        update_parser(args.lang, parsers[args.lang])
    else:
        for parser_name, parser_data in parsers.items():
            update_parser(parser_name, parser_data)
