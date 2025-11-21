return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luarc.jsonc" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			signatureHelp = { enabled = true },
			-- get the language server to recognize the 'vim' and 'require' globals
			diagnostics = {
				globals = { "vim", "require" },
			},
		},
	},
}
