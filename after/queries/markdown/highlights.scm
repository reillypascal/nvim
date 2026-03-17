;; extends

; https://vi.stackexchange.com/questions/44708/neovim-override-treesitter-spelling-settings
; https://davisvaughan.github.io/r-tree-sitter/reference/query-matches-and-captures.html#-match-regex
(link_destination) @nospell
; ((link_destination)
;       @link_destination (#match? @link_destination "\\w+:\\/\\/[^[:space:]]+")) @nospell
; ((uri_autolink)
;       @uri_autolink (#match? @uri_autolink "\\w+:\\/\\/[^[:space:]]+")) @nospell
; ((inline)
;       @element (#match? @element "<\\w+>")) @nospell
; ((inline)
;       @inline (#contains? @inline "http://")) @nospell
