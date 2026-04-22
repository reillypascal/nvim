-- https://codeberg.org/rgherdt/scheme-lsp-server
-- via https://github.com/aconchillo/homebrew-guile
return {
	cmd = { "guile-lsp-server" },
	filetypes = { "scheme" },
	workspace_required = false,
	root_markers = { "Akku.manifest", ".git" },
}
