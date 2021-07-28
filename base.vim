function! CompilePacker()
  echo "Removing packer_compiled.vim"
  exec "!rm ~/.config/nvim/plugin/packer_compiled.lua"
  echo "Compiling packer..."
  exec ":PackerCompile"
  echo "Compiling done!"
endfunction

augroup plugins
  au!
  autocmd BufWritePost *.lua :call CompilePacker()
augroup end

" disable status line for nvimtree
au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "NvimTree" | set laststatus=0 | else | set laststatus=2 | endif

au FileType TelescopePrompt let b:delimitMate_autoclose = 0

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

" Use backspace key for matching parens
nmap <BS> %
xmap <BS> %

" Repeat latest f, t, F or T
nnoremap \ ;

" Select last paste
nnoremap <expr> gp '`['.strpart(getregtype(), 0, 1).'`]'

" Quick substitute within selected area
xnoremap sg :s/\v/g<Left><Left>
xnoremap sc :s/\v/gc<Left><Left><Left>

" C-r: Easier search and replace visual/select mode
xnoremap <C-r> :<C-u>%s/\V<C-R>=<SID>get_selection()<CR>//gc<Left><Left><Left>

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

" Start an external command with a single bang
nnoremap ! :!

" Put vim command output into buffer
nnoremap g! :<C-u>put=execute('')<Left><Left>

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
