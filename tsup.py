#!/usr/bin/env python3

# TODO:
#   - break out parser build into fn so can add "parser_deps" that uses it too
#   - git sparse clone query repo
#       - https://stackoverflow.com/a/52269934
#       - https://github.com/romus204/tree-sitter-manager.nvim
#       - https://github.com/nvim-treesitter/nvim-treesitter

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

query_repo = "https://github.com/romus204/tree-sitter-manager.nvim"
query_repo_dir = path.basename(query_repo)
# Dict typing: https://stackoverflow.com/a/66731847
parsers: Dict[str, Any] = {
    "bash": {
        "repo": "https://github.com/tree-sitter/tree-sitter-bash",
        "use_repo_queries": False,
    },
    "c": {
        "repo": "https://github.com/tree-sitter/tree-sitter-c",
        "use_repo_queries": False,
    },
    "cmake": {
        "repo": "https://github.com/uyha/tree-sitter-cmake",
        "use_repo_queries": False,
    },
    "cpp": {
        "repo": "https://github.com/tree-sitter/tree-sitter-cpp",
        "build_deps": ["tree-sitter-c"],
        "use_repo_queries": False,
    },
    "css": {
        "repo": "https://github.com/tree-sitter/tree-sitter-css",
        "use_repo_queries": False,
    },
    "genexpr": {
        "repo": "https://github.com/isabelgk/tree-sitter-genexpr",
        "use_repo_queries": True,
    },
    "haskell": {
        "repo": "https://github.com/tree-sitter-grammars/tree-sitter-haskell",
        "use_repo_queries": False,
    },
    "html": {
        "repo": "https://github.com/tree-sitter/tree-sitter-html",
        "query_deps": {
            "html_tags": {
                "repo": "https://github.com/neovim-treesitter/nvim-treesitter-queries-html_tags",
                "use_repo_queries": False,
            }
        },
        "use_repo_queries": False,
    },
    "javascript": {
        "repo": "https://github.com/tree-sitter/tree-sitter-javascript",
        "query_deps": {
            "ecma": {
                "repo": "https://github.com/neovim-treesitter/nvim-treesitter-queries-ecma",
                "use_repo_queries": False,
            },
            "jsx": {
                "repo": "https://github.com/neovim-treesitter/nvim-treesitter-queries-jsx",
                "use_repo_queries": False,
            },
        },
        "use_repo_queries": False,
    },
    "json": {
        "repo": "https://github.com/tree-sitter/tree-sitter-json",
        "use_repo_queries": False,
    },
    "latex": {
        "repo": "https://github.com/latex-lsp/tree-sitter-latex",
        "use_repo_queries": False,
    },
    "liquid": {
        "repo": "https://github.com/hankthetank27/tree-sitter-liquid",
        "use_repo_queries": False,
    },
    "make": {
        "repo": "https://github.com/tree-sitter-grammars/tree-sitter-make",
        "use_repo_queries": False,
    },
    "python": {
        "repo": "https://github.com/tree-sitter/tree-sitter-python",
        "use_repo_queries": False,
    },
    "rust": {
        "repo": "https://github.com/tree-sitter/tree-sitter-rust",
        "use_repo_queries": False,
    },
    "scheme": {
        "repo": "https://github.com/6cdh/tree-sitter-scheme",
        "use_repo_queries": False,
    },
    "sql": {
        "repo": "https://github.com/derekstride/tree-sitter-sql",
        "use_repo_queries": False,
    },
    "supercollider": {
        "repo": "https://github.com/madskjeldgaard/tree-sitter-supercollider",
        "use_repo_queries": False,
    },
    "toml": {
        "repo": "https://github.com/tree-sitter-grammars/tree-sitter-toml",
        "query_deps": {
            "dtd": {
                "repo": "https://github.com/neovim-treesitter/nvim-treesitter-queries-dtd",
                "use_repo_queries": False,
            }
        },
        "use_repo_queries": False,
    },
    "xml": {
        "repo": "https://github.com/tree-sitter-grammars/tree-sitter-xml",
        "use_repo_queries": False,
    },
    "yaml": {
        "repo": "https://github.com/tree-sitter-grammars/tree-sitter-yaml",
        "use_repo_queries": False,
    },
    "zig": {
        "repo": "https://github.com/tree-sitter-grammars/tree-sitter-zig",
        "use_repo_queries": False,
    },
    "zsh": {
        "repo": "https://github.com/georgeharker/tree-sitter-zsh",
        "use_repo_queries": False,
    },
}


def clone_or_pull(dir, repo):
    if path.exists(dir):
        call(["git", "-C", dir, "pull"])
    else:
        call(["git", "clone", repo])


def copy_files(searches, root_dir, dest_dir):
    # copy query .scm files to treesitter dir
    call(["mkdir", "-p", f"{dest_dir}"])
    for search in searches:
        for file in glob(
            f"{search}",
            root_dir=f"{root_dir}",
            recursive=True,
        ):
            copy(
                f"{root_dir}/{file}",
                f"{dest_dir}/",
            )


def update_parser(parser_name, parser_data):
    parser_dir = path.basename(parser_data["repo"])

    # clone parser, or update existing clone
    clone_or_pull(parser_dir, parser_data["repo"])

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

        # generate and build parser; with chdir returns to original path when done
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
        copy_files(
            [f"**/*{system_so_ext}"],
            parser_dir,
            f"{ts_dir}/parser/",
        )

        if parsers[parser_name]["use_repo_queries"]:
            # copy query .scm files to treesitter dir
            copy_files(
                ["**/queries/*.scm", f"**/{parser_name}/*.scm"],
                parser_dir,
                f"{ts_dir}/queries/{parser_name}/",
            )
        # if use_repo_queries is False
        else:
            copy_files(
                [f"**/{parser_name}/*.scm"],
                query_repo_dir,
                f"{ts_dir}/queries/{parser_name}/",
            )
    # if could not find grammar.js
    else:
        print(f"Could not find grammar for {parser_name}/")

    # clone query dependencies
    if "query_deps" in parsers[parser_name]:
        for query_name, query_data in parsers[parser_name]["query_deps"].items():
            query_dir = path.basename(query_data["repo"])

            # clone query, or update existing clone
            clone_or_pull(query_dir, query_data["repo"])

            # find director(y/ies) of query .scm files
            copy_files(
                ["**/queries/*.scm", f"**/{query_name}/*.scm"],
                build_dir,
                f"{ts_dir}/queries/{parser_name}",
            )


def list_parsers(parser_dict) -> str:
    parser_list = "\n".join(f"{key}" for key, _ in parser_dict.items())
    return parser_list


with chdir(build_dir):
    # list only if '-l' flag set
    if args.list:
        print(list_parsers(parsers))
    # if '-l' flag not set, download and build
    else:
        clone_or_pull(query_repo_dir, query_repo)
        # only install values of '-i' if set
        if args.include:
            # list; may be more than 1 item
            for lang in args.include:
                update_parser(lang, parsers[lang])
        # if no include list
        else:
            # list; may be more than 1 item
            for parser_name, parser_data in parsers.items():
                # update parser unless '-e' is set and parser is in '-e' list
                if not (args.exclude and parser_name in args.exclude):
                    update_parser(parser_name, parser_data)
