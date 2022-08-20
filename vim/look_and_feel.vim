"-----------------------------------------------------------------------------
"Colors
"-----------------------------------------------------------------------------

syntax on
nnoremap <F12> :syntax sync fromstart<CR>

set t_Co=256
colorscheme tir_black

set sidescrolloff=2
set numberwidth=4
set cursorline
set colorcolumn=+1,81

"Syntax highlight options
let c_char_is_integer=1
let c_space_errors=1
let c_gnu=1
let c_syntax_for_h=1
let c_C94=1
let c_C99=1
let c_conditional_is_operator=1
let c_no_octal=1
let c_ansi_typedefs=1
let c_ansi_constants=1
let c_posix=1
let c_math=1
let c_gnu=1
let python_highlight_all=1
let python_highlight_space_errors=0
let g:jinja_syntax_html=0

" Display the highlight group for under the cursor
function! SynStack()
	if !exists("*synstack")
		return
	endif
	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction

nnoremap <C-h> :call SynStack()<CR>

"-----------------------------------------------------------------------------
"Status Line
"-----------------------------------------------------------------------------

set showcmd
set ruler

"Define 3 custom highlight groups
hi User1 ctermfg=red   guifg=red
hi User2 ctermfg=blue  guifg=blue
hi User3 ctermfg=green guifg=green

set statusline=

set statusline+=%f    "tail of the filename
set statusline+=%1*   "switch to User1 highlight
set statusline+=%h    "help file flag
set statusline+=%m    "modified flag
set statusline+=%r    "read only flag
set statusline+=%*\   "switch back to statusline highlight

set statusline+=%2*   "switch to User2 highlight
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}]   "file format
set statusline+=%*\   "switch back to statusline highlight

set statusline+=%3*   "switch to User3 highlight
set statusline+=%y    "filetype
set statusline+=%*    "switch back to statusline highlight

set statusline+=%=    "left/right separator
set statusline+=c%c\  "cursor column
set statusline+=%l/%L "cursor line/total lines
set statusline+=\ %P  "percent through file

set laststatus=2      "always show statusline
