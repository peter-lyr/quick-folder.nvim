
py3 import os, vim; vim.command(f'let g:sep = "{os.path.sep}"')
let g:path_home_directory = expand('~') .g:sep

let b:my_quick_folder = {'home': [''], 'desktop': ['']}

function! OpenSide(folder, mode)
    if and(a:mode == 't', len(expand('%:p')) > 0)
        exec 'tabnew'
    endif
    exec 'cd ' .a:folder
    exec "Defx `'" .a:folder ."'`"
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
    if !exists('g:quick_folder')
        let g:quick_folder = b:my_quick_folder
    endif
    for i in g:quick_folder.home
        let n = s:get_n(i)
        exec 'nnoremap ch' .n ' :call OpenSide("' .g:path_home_directory .i .'", "b")<cr>'
        exec 'nnoremap cH' .n ' :call OpenSide("' .g:path_home_directory .i .'", "t")<cr>'
    endfor
    for i in g:quick_folder.desktop
        let n = s:get_n(i)
        exec 'nnoremap cd' .n ' :call OpenSide("' .g:path_home_directory .'Desktop' .g:sep .i .'", "b")<cr>'
        exec 'nnoremap cD' .n ' :call OpenSide("' .g:path_home_directory .'Desktop' .g:sep .i .'", "t")<cr>'
    endfor
endfunction

function! ViewChangeFolder()
    ec "The quick folders:"
    let c = 1
    for i in g:quick_folder.home
        ec c .'. ' .g:path_home_directory .i
        let c = c + 1
    endfor
    for i in g:quick_folder.home
        ec c .'. ' .g:path_home_directory . 'Desktop' .g:sep .i
        let c = c + 1
    endfor
endfunction

autocmd VimEnter * :call MapChangeFolder()
command! ViewChangeFolder call ViewChangeFolder()
