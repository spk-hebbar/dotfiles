setlocal shiftwidth=4
setlocal tabstop=4
setlocal expandtab
setlocal softtabstop=4
setlocal formatoptions=vcq
setlocal nosmartindent
setlocal cindent
setlocal completeopt-=preview

if isdirectory('.venv')
	let $VIRTUAL_ENV = fnamemodify('.venv', ':p')
endif
