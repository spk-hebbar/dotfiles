" tir_black color scheme
" Based on ir_black from: http://blog.infinitered.com/entries/show/8
" adds 256 color console support
" changed WildMenu color to be the same as PMenuSel

set background=dark
hi clear

if exists("syntax_on")
	syntax reset
endif

let colors_name = "tir_black"

" General colors
hi Normal           ctermfg=none
hi NonText          ctermfg=232

hi Cursor           ctermfg=0 ctermbg=15
hi LineNr           ctermfg=239

hi VertSplit        ctermfg=235 ctermbg=235
hi StatusLine       ctermfg=235 ctermbg=254
hi StatusLineNC     ctermfg=0 ctermbg=235

hi Folded           ctermfg=103 ctermbg=60
hi Title            ctermfg=187 cterm=bold
hi Visual           cterm=reverse

hi SpecialKey       ctermfg=15 ctermbg=9
hi ExtraWhitespace  ctermfg=15 ctermbg=9
hi Whitespace       ctermfg=236 ctermbg=233

hi Error            ctermfg=none ctermbg=red
hi ErrorMsg         ctermfg=none ctermbg=203 cterm=bold
hi WarningMsg       ctermfg=none ctermbg=203 cterm=bold
hi LongLineWarning  cterm=underline

hi ModeMsg          ctermfg=0 ctermbg=189 cterm=bold

hi CursorLine       ctermbg=233 cterm=none
hi ColorColumn      ctermbg=234 cterm=none
hi CursorColumn     ctermbg=233 cterm=none
hi MatchParen       ctermfg=none ctermbg=darkgray

hi TabLine          ctermfg=102 ctermbg=233 cterm=NONE
hi TabLineSel       ctermfg=15 ctermbg=59 cterm=NONE
hi TabLineFill      ctermfg=233 ctermbg=233 cterm=NONE

hi Pmenu            ctermfg=15 ctermbg=23 cterm=NONE
hi PmenuSet         ctermfg=81 ctermbg=233 cterm=NONE
hi PmenuSBar        ctermfg=81 ctermbg=59 cterm=NONE
hi PmenuSel         ctermfg=81 ctermbg=59 cterm=NONE
hi PmenuThumb       ctermfg=103 ctermbg=103 cterm=NONE

hi Search           ctermfg=15 ctermbg=21

" Syntax highlighting
hi Comment          ctermfg=9
hi String           ctermfg=155
hi Number           ctermfg=207

hi Keyword          ctermfg=117
hi PreProc          ctermfg=117
hi Conditional      ctermfg=110

hi Todo             ctermfg=207 ctermbg=0 cterm=bold
hi Constant         ctermfg=151

hi Identifier       ctermfg=189
hi Function         ctermfg=223
hi Type             ctermfg=229
hi Statement        ctermfg=110

hi Special          ctermfg=173
hi Delimiter        ctermfg=37
hi Operator         ctermfg=110

hi SpellBad         ctermfg=none ctermbg=52
hi clear SpellCap
hi clear SpellRare
hi clear SpellLocal

hi link Character Constant
hi link Boolean Constant
hi link Float Number
hi link Repeat Statement
hi link Label Statement
hi link Exception Statement
hi link Include PreProc
hi link Define PreProc
hi link Macro PreProc
hi link PreCondit PreProc
hi link StorageClass Type
hi link Structure Type
hi link Typedef Type
hi link Tag Special
hi link SpecialChar Special
hi link SpecialComment Special
hi link Debug Special

" Special for Ruby
hi rubyRegexp ctermfg=brown
hi rubyRegexpDelimiter ctermfg=brown
hi rubyEscape ctermfg=cyan
hi rubyInterpolationDelimiter ctermfg=blue
hi rubyControl ctermfg=blue "and break, etc
hi rubyStringDelimiter ctermfg=lightgreen
hi link rubyClass Keyword
hi link rubyModule Keyword
hi link rubyKeyword Keyword
hi link rubyOperator Operator
hi link rubyIdentifier Identifier
hi link rubyInstanceVariable Identifier
hi link rubyGlobalVariable Identifier
hi link rubyClassVariable Identifier
hi link rubyConstant Type

" Special for Java
hi link javaScopeDecl Identifier
hi link javaCommentTitle javaDocSeeTag
hi link javaDocTags javaDocSeeTag
hi link javaDocParam javaDocSeeTag
hi link javaDocSeeTagParam javaDocSeeTag

hi javaDocSeeTag ctermfg=darkgray
hi javaDocSeeTag ctermfg=darkgray

" Special for XML
hi link xmlTag Keyword
hi link xmlTagName Conditional
hi link xmlEndTag Identifier

" Special for HTML
hi link htmlTag Keyword
hi link htmlTagName Conditional
hi link htmlEndTag Identifier

" Special for Javascript
hi link javaScriptNumber Number

" Special for CSharp
hi link csXmlTag Keyword

" Special for emails
hi mailQuoted1 ctermbg=NONE ctermfg=75
hi mailQuoted2 ctermbg=NONE ctermfg=208
hi mailQuoted3 ctermbg=NONE ctermfg=141
hi mailQuoted4 ctermbg=NONE ctermfg=171
hi mailQuoted5 ctermbg=NONE ctermfg=244
hi mailQuoted6 ctermbg=NONE ctermfg=244
hi mailURL ctermbg=NONE ctermfg=229
hi mailEmail ctermbg=NONE ctermfg=229

" email patch reply
hi mailQuoteDiffMeta ctermbg=NONE ctermfg=15 cterm=bold
hi mailQuoteDiffChunk ctermbg=NONE ctermfg=6
hi mailQuoteDiffAdded ctermbg=NONE ctermfg=10
hi mailQuoteDiffRemoved ctermbg=NONE ctermfg=9

hi diffAdded        ctermbg=NONE ctermfg=10
hi diffRemoved      ctermbg=NONE ctermfg=9

" Show trailing whitespace and spaces before a tab:
match ExtraWhitespace /\s\+$\| \+\ze\t/
