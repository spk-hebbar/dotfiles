if exists("b:current_syntax")
	finish
endif

" Pull in the jinja syntax.
runtime syntax/jinja.vim
unlet b:current_syntax

syn match docfilesComment "#.*$"
syn match docfilesOperator " -> "

hi def link docfilesComment Comment
hi def link docfilesOperator Operator

let b:current_syntax = "docfiles"
