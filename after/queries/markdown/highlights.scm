;; extends
((link_destination)
      @link_destination (#match? @link_destination "\\w+:\\/\\/[^[:space:]]+")) @nospell
; ((inline)
;       @element (#match? @element "<\\w+>")) @nospell
; https://davisvaughan.github.io/r-tree-sitter/reference/query-matches-and-captures.html#-match-regex
; ((inline)
;       @inline (#contains? @inline "http://")) @nospell
