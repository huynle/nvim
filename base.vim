" function! ToggleQuickFix()
"     if empty(filter(getwininfo(), 'v:val.quickfix'))
"         copen
"     else
"         cclose
"     endif
" endfunction

" nnoremap <silent> <leader>q :call ToggleQuickFix()<cr>

function! GetBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

" nmap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>
" nmap <silent> <leader>q :call ToggleList("Quickfix List", 'c')<CR>





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


let g:fold_cycle_default_mapping = 0 "disable default mappings
nmap <Tab> <Plug>(fold-cycle-open)
nmap <S-Tab> <Plug>(fold-cycle-close)

" Won't close when max fold is opened
let g:fold_cycle_toggle_max_open  = 1
" Won't open when max fold is closed
let g:fold_cycle_toggle_max_close = 1


function! HeaderToggle()
    let filename = expand("%:t")
    if filename =~ ".cpp"
        execute "e %:r.h"
    else
        execute "e %:r.cpp"
    endif
endfunction



nnoremap <M-o> :call HeaderToggle()<cr>
