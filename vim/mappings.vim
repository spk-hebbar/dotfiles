"-----------------------------------------------------------------------------
"Key mappings
"-----------------------------------------------------------------------------

if &term =~ '\v^(tmux|screen|foot)'
	" tmux will send xterm-style keys when its xterm-keys option is on
	execute "set <F13>=\e[5;5~"
	execute "map <F13> <C-PageUp>"
	execute "map! <F13> <C-PageUp>"

	execute "set <F14>=\e[6;5~"
	execute "map <F14> <C-PageDown>"
	execute "map! <F14> <C-PageDown>"

	execute "set <F15>=\e[1;7A"
	execute "map <F15> <C-A-up>"
	execute "map! <F15> <C-A-up>"

	execute "set <F16>=\e[1;7B"
	execute "map <F16> <C-A-down>"
	execute "map! <F16> <C-A-down>"

	execute "set <F17>=\e[1;5C"
	execute "map <F17> <C-right>"
	execute "map! <F17> <C-right>"

	execute "set <F18>=\e[1;5D"
	execute "map <F18> <C-left>"
	execute "map! <F18> <C-left>"
endif

let mapleader = ','

"Cursor Movement
"Make cursor move by visual lines instead of file lines (when wrapping)
map <up> gk
map k gk
imap <up> <C-o>gk
map <down> gj
map j gj
imap <down> <C-o>gj

"Navigate through errors (location list)
function NextError()
	try
		execute "lnext"
	catch /^Vim\%((\a\+)\)\=:E553/
		execute "lfirst"
	catch /^Vim\%((\a\+)\)\=:E\%(776\|42\):/
		echohl ErrorMsg
		echomsg "No errors"
		echohl None
	endtry
endfunction

function PrevError()
	try
		execute "lprev"
	catch /^Vim\%((\a\+)\)\=:E553/
		execute "llast"
	catch /^Vim\%((\a\+)\)\=:E\%(776\|42\):/
		echohl ErrorMsg
		echomsg "No errors"
		echohl None
	endtry
endfunction

nnoremap e :call NextError()<CR>
nnoremap E :call PrevError()<CR>

"Delete line with <ctrl-d>
inoremap <C-d> <Esc>ddi
vnoremap <C-d> d
nnoremap <C-d> dd

"Move lines up and down with <Ctrl-Alt-up> & <Ctrl-Alt-down> keys
nnoremap <C-A-down> :m+<CR>==
nnoremap <C-A-up> :m-2<CR>==
inoremap <C-A-down> <Esc>:m+<CR>==gi
inoremap <C-A-up> <Esc>:m-2<CR>==gi
vnoremap <C-A-down> :m'>+<CR>gv=gv
vnoremap <C-A-up> :m-2<CR>gv=gv

"Indent selection with <tab> key
vnoremap <tab> >gv
"Unindent seletction with <Shift-tab> command
vnoremap <S-tab> <gv

"Reflow current paragraph with F
nnoremap F gqap
vnoremap F gq

"Insert New Line
map <S-Enter> O<Esc>
map <Enter> o<Esc>

"Disable cursor blink (t_RC) and cursor style (t_RS) term responses to allow
"esc-based mappings with recent vim versions
set t_RC= t_RS=
nnoremap <Esc>P :set paste!<CR>
nnoremap <Esc>N :set number!<CR>

"Only tabs (8 spaces per level)
map <F5> :set shiftwidth=8<CR>:set tabstop=8<CR>:set noexpandtab<CR>:set softtabstop=8<CR>
"Only spaces (4 spaces by level)
map <F6> :set shiftwidth=4<CR>:set tabstop=4<CR>:set expandtab<CR>:set softtabstop=4<CR>
"Only spaces (2 spaces by level)
map <F7> :set shiftwidth=2<CR>:set tabstop=2<CR>:set expandtab<CR>:set softtabstop=2<CR>

"Allow switching buffers without saving
set hidden
"Switch buffers bindings
nnoremap <C-PageUp> :bprev<CR>
nnoremap <C-PageDown> :bnext<CR>

nnoremap <F9> :set spell!<CR>

nnoremap bb :bd<CR>

"Pipe selection to pastebin and print URL in statusbar
vnoremap Y <esc>:'<,'>:w !curl -LSsF file=@- https://0x0.st<CR>

function InsertAckedBy()
	let expr = input('Acked-by: ')
	if expr == ''
		return
	endif
	let cmd = 'git people ' . expr
	put =system(cmd)
endfunction

nnoremap <F4> :call InsertAckedBy()<CR>

function InsertFixes()
	let commitid = input('Fixes: ')
	if commitid == ''
		return
	endif
	let cmd = 'git lfixes -n1 ' . commitid
	put =system(cmd)
endfunction

nnoremap <F2> :call InsertFixes()<CR>

function InsertLicense()
	let license = 'Copyright (c) ' . strftime('%Y') . ' Robin Jarry'

	if b:current_syntax == 'rst'
		let copyright = '.. ' . license
	elseif b:current_syntax == 'c' || b:current_syntax == 'c+ifdef' || b:current_syntax == 'javascript'
		let copyright = '/* ' . license . ' */'
	elseif b:current_syntax == 'vim'
		let copyright = '"' . license
	else "shell, python, Makefile, etc.
		let copyright = '# ' . license
	endif

	put =copyright
endfunction

nnoremap <C-l> :call InsertLicense()<CR>

"-----------------------------------------------------------------------------
"tags
"-----------------------------------------------------------------------------

nnoremap <silent> ù <C-]>
nnoremap <silent> ! :silent tnext<CR>

"-----------------------------------------------------------------------------
"Cscope
"-----------------------------------------------------------------------------

function InitCscope()
	set cscopetag " use cscope with ctags shortcuts
	set cspc=9 " display full path names
	set nocscoperelative
	set nocscopeverbose
	let l:root = GitRoot()
	call system('cd ' . l:root . ' && cscope -bR')
	exec 'cscope add ' . l:root . '/cscope.out'
	set cscopeverbose
	nnoremap <buffer> <silent> <F3> :cs find g <C-R>=expand("<cword>")<CR><CR>
endfunction

autocmd FileType c call InitCscope()
