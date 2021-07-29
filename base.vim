function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction

nnoremap <silent> <leader>q :call ToggleQuickFix()<cr>


"=================== general useful stuff

" }}}
" Search & Replace {{{
" ----------------

" Repeat latest f, t, F or T
nnoremap \ ;


" Returns visually selected text
function! s:get_selection() abort "{{{
	try
		let a_save = @a
		silent! normal! gv"ay
		return substitute(escape(@a, '\/'), '\n', '\\n', 'g')
	finally
		let @a = a_save
	endtry
endfunction "}}}

" }}}
" Command & History {{{
" -----------------


" Allow misspellings
cnoreabbrev qw wq
cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev Qa qa
cnoreabbrev Bd bd
cnoreabbrev bD bd


" Source line and selection in vim
vnoremap <localleader>S y:execute @@<CR>:echo 'Sourced selection.'<CR>
nnoremap <localleader>S ^vg_y:execute @@<CR>:echo 'Sourced line.'<CR>


function ClearQuickfixList()
  call setqflist([])
endfunction
command! ClearQuickfixList call ClearQuickfixList()
nmap <leader>qc :ClearQuickfixList<cr>
