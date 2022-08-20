" Kconfig file
au BufNewFile,BufRead *Mconfig                 setf kconfig
au BufNewFile,BufRead Config.in                        setf kconfig

" 6WIND doc.files
au BufNewFile,BufRead doc.files                        setf docfiles

au BufNewFile,BufRead components               setf make
au BufNewFile,BufRead *.inc                    setf rst
