" https://www.panozzaj.com/blog/2016/03/22/ignore-urls-and-acroynms-while-spell-checking-vim/
:syn match UrlNoSpell "\w\+:\/\/[^[:space:]]\+" contains=@NoSpell
:syn match AcronymNoSpell '\<\(\u\|\d\)\{3,}s\?\>' contains=@NoSpell
" Match task text between checkbox and optional tag
" https://www.rexegg.com/regex-boundaries.php
" :syn match HtmlCommentNoSpell '\<!\-\-).*\-\-\>' contains=@NoSpell
" https://stackoverflow.com/a/27253700
" :syn spell toplevel
