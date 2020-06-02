
py3 import os, vim; vim.command(f'let g:sep = "{os.path.sep}"')
let g:path_home_directory = expand('~') .g:sep

let g:quick_folder = {'home': [''], 'desktop': ['']}

function! OpenSide(folder)
    let path = expand('%:p')
    if len(path) > 0
        exec 'tabnew'
    endif
    exec 'cd ' .a:folder
    exec "Defx `expand('%:p:h')` -search=`expand('%:p')`"
endfunction

function! s:get_n(i)
    let fs = split(a:i, '/')
    if len(fs) == 0
        return '/'
    else
        return trim(fs[len(fs)-1], '.')[0:1]
    endif
endfunction

function! MapChangeFolder()
    for i in g:quick_folder.home
        let n = s:get_n(i)
        exec 'nnoremap ch' .n ' :call OpenSide("' .g:path_home_directory .i .'")<cr>'
    endfor
    for i in g:quick_folder.desktop
        let n = s:get_n(i)
        exec 'nnoremap cd' .n ' :call OpenSide("' .g:path_home_directory .'Desktop/' .i .'")<cr>'
    endfor
endfunction

call MapChangeFolder()
