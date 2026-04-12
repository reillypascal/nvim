#!/usr/bin/env python3

# TODO:
#   - break into smaller functions
#   - check if current commit matches remote; if so, don't run build/copy
#   - git sparse clone for e.g., LaTeX
#       - https://stackoverflow.com/a/52269934
#       - https://github.com/nvim-treesitter/nvim-treesitter/tree/main/runtime/queries/latex
#   - check for precompiled binaries: e.g., sql: https://github.com/derekstride/tree-sitter-sql?tab=readme-ov-file#installation

from argparse import ArgumentParser
from contextlib import chdir
from glob import glob
from os import environ, path, walk
from platform import system
from shutil import copy, copytree
from subprocess import call
from typing import Any, Dict

parser = ArgumentParser()
# alternative: allow appending to repeat argument flag https://stackoverflow.com/a/77879961
parser.add_argument(
    "-e", "--exclude", help="Exclude one or more languages from update", nargs="*"
)
parser.add_argument(
    "-i",
    "--include",
    help="Select one or more languages (and their dependencies) to update",
    nargs="*",
)
parser.add_argument(
    "-l", "--list", help="List all available parsers", action="store_true"
)
parser.add_argument(
    "-t", "--test", help="Use testing directory for destination", action="store_true"
)
args = parser.parse_args()

ts_dir = ""
if args.test:
    # alternate destination dir for testing
    ts_dir = f"{environ["HOME"]}/Downloads/site"
else:
    ts_dir = f"{environ["HOME"]}/.local/share/nvim/site"

build_dir = f"{environ["HOME"]}/Downloads"

# https://stackoverflow.com/a/66731847
parsers: Dict[str, Any] = {
    "bash": {
        "repo": "https://github.com/tree-sitter/tree-sitter-bash",
    },
    "cmake": {"repo": "https://github.com/uyha/tree-sitter-cmake"},
    "cpp": {
        "repo": "https://github.com/tree-sitter/tree-sitter-cpp",
        "build_deps": ["tree-sitter-c"],
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
    "sql": {"repo": "https://github.com/derekstride/tree-sitter-sql"},
    "supercollider": {
        "repo": "https://github.com/madskjeldgaard/tree-sitter-supercollider"
    },
    "toml": {
        "repo": "https://github.com/tree-sitter-grammars/tree-sitter-toml",
        "query_deps": [
            "https://github.com/neovim-treesitter/nvim-treesitter-queries-dtd"
        ],
    },
    "xml": {"repo": "https://github.com/tree-sitter-grammars/tree-sitter-xml"},
    "yaml": {"repo": "https://github.com/tree-sitter-grammars/tree-sitter-yaml"},
    "zig": {"repo": "https://github.com/tree-sitter-grammars/tree-sitter-zig"},
    "zsh": {"repo": "https://github.com/georgeharker/tree-sitter-zsh"},
}


def update_parser(parser_name, parser_data):
    parser_dir = path.basename(parser_data["repo"])

    # clone parser, or update existing clone
    if path.exists(parser_dir):
        call(["git", "-C", parser_dir, "pull"])
    else:
        call(["git", "clone", parser_data["repo"]])

    # add build deps with npm
    if "build_deps" in parsers[parser_name]:
        for dep in parsers[parser_name]["build_deps"]:
            call(["npm", "i", dep])

    # find grammar; note folder in order to generate/build there
    paths_to_search = [
        f"{parser_dir}",
        f"{parser_dir}/src",
        f"{parser_dir}/{parser_name}",
        f"{parser_dir}/{parser_name}/src",
    ]
    parser_build_dir = ""
    did_find_grammar = False
    for candidate in paths_to_search:
        if path.exists(f"{candidate}/grammar.js"):
            parser_build_dir = candidate
            did_find_grammar = True
            break

    if did_find_grammar:
        system_so_exts = {"Darwin": ".dylib", "Linux": ".so", "Windows": ".dll"}
        system_so_ext = system_so_exts[system()]

        # generate and build parser
        # with chdir returns to original path when done
        # NOTE: generate/build comands are usually silent: https://tree-sitter.github.io/tree-sitter/cli/generate.html
        with chdir(parser_build_dir):
            # inside dir to ensure can find grammar.json
            call(["tree-sitter", "generate"])
            call(
                [
                    "tree-sitter",
                    "build",
                    # doesn't seem to need to be outside dir for cpp
                    # parser_build_dir,
                    "-o",
                    f"{parser_name}{system_so_ext}",
                ]
            )

        # copy parser dylibs to treesitter dir
        call(["mkdir", "-p", f"{ts_dir}/parser"])
        for file in glob(
            f"**/*{system_so_ext}", root_dir=f"{build_dir}/{parser_dir}", recursive=True
        ):
            copy(f"{build_dir}/{parser_dir}/{file}", f"{ts_dir}/parser/")

        # copy query .scm files to treesitter dir
        for candidate in paths_to_search:
            if path.exists(f"{candidate}/queries"):
                for root, _, files in walk(f"{candidate}/queries"):
                    for filename in files:
                        parent_dir = path.basename(root)
                        # if there is just one "queries/" in parser
                        if parent_dir == "queries":
                            call(["mkdir", "-p", f"{ts_dir}/queries/{parser_name}"])
                            copy(
                                path.join(root, filename),
                                f"{ts_dir}/queries/{parser_name}/",
                            )
                        # if multiple language queries (e.g., in xml)
                        else:
                            call(["mkdir", "-p", f"{ts_dir}/queries/{parent_dir}"])
                            copy(
                                path.join(root, filename),
                                f"{ts_dir}/queries/{parent_dir}/",
                            )
    else:
        print(f"Could not find grammar for {parser_name}")

    # clone query dependencies
    if "query_deps" in parsers[parser_name]:
        for dep in parsers[parser_name]["query_deps"]:
            query_dir = path.basename(dep)
            query_name = dep.rsplit("-", 1)[1]

            # clone query, or update existing clone
            if path.exists(query_dir):
                call(["git", "-C", query_dir, "pull"])
            else:
                call(["git", "clone", dep])

            # find director(y/ies) of query .scm files
            query_paths_to_search = [
                f"{query_dir}",
                f"{query_dir}/src",
                f"{query_dir}/{query_name}",
                f"{query_dir}/{query_name}/src",
            ]
            for candidate in query_paths_to_search:
                if path.exists(f"{candidate}/queries"):
                    for root, _, files in walk(f"{candidate}/queries"):
                        for filename in files:
                            parent_dir = path.basename(root)
                            # if there is just one "queries/" in parser
                            if parent_dir == "queries":
                                call(["mkdir", "-p", f"{ts_dir}/queries/{query_name}"])
                                copy(
                                    path.join(root, filename),
                                    f"{ts_dir}/queries/{query_name}/",
                                )
                            # if multiple language queries (e.g., in xml)
                            else:
                                call(["mkdir", "-p", f"{ts_dir}/queries/{parent_dir}"])
                                copy(
                                    path.join(root, filename),
                                    f"{ts_dir}/queries/{parent_dir}/",
                                )


def list_parsers(parser_dict) -> str:
    parser_list = "\n".join(f"{key}" for key, _ in parser_dict.items())
    return parser_list


with chdir(build_dir):
    # only list parsers if '-l' flag set
    if args.list:
        print(list_parsers(parsers))
    # if '-l' flag not set,
    else:
        # only list values of '-i' if set
        if args.include:
            # list; may be more than 1 item
            for lang in args.include:
                update_parser(lang, parsers[lang])
        else:
            # list; may be more than 1 item
            for parser_name, parser_data in parsers.items():
                # 'True' unless '-e' set and parser is in '-e' list
                if not (args.exclude and parser_name in args.exclude):
                    update_parser(parser_name, parser_data)
