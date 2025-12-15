" https://www.panozzaj.com/blog/2016/03/22/ignore-urls-and-acroynms-while-spell-checking-vim/
:syn match UrlNoSpell "\w\+:\/\/[^[:space:]]\+" contains=@NoSpell
:syn match AcronymNoSpell '\<\(\u\|\d\)\{3,}s\?\>' contains=@NoSpell
