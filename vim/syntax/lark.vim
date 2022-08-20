" Vim syntax file
" LARK:	LARK, A modern parsing library for Python

" quit when a syntax file was already loaded
if exists("b:current_syntax")
   finish
endif

syn match larkOperator "\v:"
syn match larkOperator "\v\("
syn match larkOperator "\v\)"
syn match larkOperator "\v\["
syn match larkOperator "\v\]"
syn match larkOperator "\v\*"
syn match larkOperator "\v\+"
syn match larkOperator "\v\?"
syn match larkOperator "\v\!"
syn match larkOperator "\v->"
syn match larkOperator "\v\."
syn match larkDirective "\v\%import"
syn match larkDirective "\v\%ignore"

syn match larkParserRule "\v[_a-z][_a-z0-9]+"
syn match larkLexerRule "\v[_A-Z][_A-Z0-9]+"
syn region larkString start=+\v"+ end=+\v"i?+ skip=+\v\\.+
syn region larkString start="\v/" end="\v/" skip="\v\\."
syn match larkComment "\v//.*$"


hi def link larkComment Comment
hi def link larkOperator Operator
hi def link larkDirective PreProc
hi def link larkString String
hi def link larkParserRule Function
hi def link larkLexerRule Special


let b:current_syntax = "lark"

" vim: ts=8
