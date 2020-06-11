py3 import os, vim; vim.command(f"let g:sep = '{os.path.sep}'")
let g:home_root = expand('~') .g:sep

let b:my_quick_folder = {'home': [''], 'desktop': ['']}

"转义单双引号
function! s:escape(content, pattern)
    let content = escape(a:content, a:pattern)
    return content
endfunction


function! OpenSide(folder, mode)
    if and(a:mode == 't', len(expand('%:p')) > 0)
        exec 'tabnew'
    endif
    exec 'cd ' .a:folder
    if expand('%')[0:5] == '[defx]'
        exec "Defx"
    endif
    exec "Defx `'" .a:folder ."'`"
endfunction

function! s:get_n(i)
    let fs = split(a:i, g:sep)
    if len(fs) == 0
        return g:sep
    else
        return trim(fs[len(fs)-1], '.')[0:1]
    endif
endfunction

function! MapChangeFolder()
    if !exists('g:quick_folder')
        let g:quick_folder = b:my_quick_folder
    endif
    let patt = '\'
    for i in g:quick_folder.home
        let n = s:get_n(i)
        exec s:escape('nnoremap <silent> ch' .n .' :call OpenSide("' .g:home_root .i .'", "b")<cr>', patt)
        exec s:escape('nnoremap <silent> cH' .n .' :call OpenSide("' .g:home_root .i .'", "t")<cr>', patt)
        "call OpenSide(g:home_root .i, "b")
        "return
    endfor
    for i in g:quick_folder.desktop
        let n = s:get_n(i)
        exec s:escape('nnoremap <silent> cd' .n .' :call OpenSide("' .g:home_root .'Desktop' .g:sep .i .'", "b")<cr>', patt)
        exec s:escape('nnoremap <silent> cD' .n .' :call OpenSide("' .g:home_root .'Desktop' .g:sep .i .'", "t")<cr>', patt)
    endfor
endfunction

function! ViewChangeFolder()
    ec "The quick folders:"
    let c = 1
    for i in g:quick_folder.home
        ec c .'. ' .g:home_root .i
        let c = c + 1
    endfor
    for i in g:quick_folder.home
        ec c .'. ' .g:home_root . 'Desktop' .g:sep .i
        let c = c + 1
    endfor
endfunction

autocmd VimEnter * :call MapChangeFolder()
command! ViewChangeFolder call ViewChangeFolder()
