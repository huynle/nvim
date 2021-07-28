function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction

nnoremap <silent> <leader>q :call ToggleQuickFix()<cr>


"=================== general useful stuff

" Smart wrap toggle (breakindent and colorcolumn toggle as-well)
nmap <localleader>tw :execute('setlocal wrap! breakindent! colorcolumn=' .
	\ (&colorcolumn == '' ? &textwidth : ''))<CR>

" Change current word in a repeatable manner
nnoremap <localleader>cn *``cgn
nnoremap <localleader>cN *``cgN

" Change selected word in a repeatable manner
vnoremap <expr> <localleader>cn "y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>" . "``cgn"
vnoremap <expr> <localleader>cN "y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>" . "``cgN"

" Duplicate paragraph
nnoremap <localleader>cp yap<S-}>p

" Remove spaces at the end of lines
nnoremap <localleader>cw :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>

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
