" default settings
let g:gutentags_enabled = 0

" on save
let g:rsync_enable = 0
let g:rsync_auto_write_project = 0
let g:rsync_auto_write_file = 0
let g:rsync_exclude_gitignore = 1
let g:rsync_exclude_git = 1

" server
let g:rsync_server  = ""
let g:rsync_remote_dir  = "~/work/tempdir"
let b:rsync_cur_file = @%

" DON't end with forward slash
let b:rsync_local   = "$PROJECT"
let g:rsync_exclude = $VIMPATH."/rsync_exclude"


let g:easy_align_delimiters = {
\ '>': { 'pattern': '>>\|=>\|>' },
\ '\': { 'pattern': '\\',  'left_margin': 0, 'right_margin': 0, 'stick_to_left': 0 },
\ '/': {
\     'pattern':         '//\+\|/\*\|\*/',
\     'delimiter_align': 'l',
\     'ignore_groups':   ['!Comment'] },
\ ']': {
\     'pattern':       '[[\]]',
\     'left_margin':   0,
\     'right_margin':  0,
\     'stick_to_left': 0
\   },
\ ')': {
\     'pattern':       '[()]',
\     'left_margin':   0,
\     'right_margin':  0,
\     'stick_to_left': 0
\   },
\ 'd': {
\     'pattern':      ' \(\S\+\s*[;=]\)\@=',
\     'left_margin':  0,
\     'right_margin': 0
\   }
\ }


" ######### CPP configs
" cpp settings setting up FSSwitch to work
au! BufEnter *.h let b:fswitchdst = 'cpp' | let b:fswitchlocs = '..'
au! BufEnter *.cpp let b:fswitchdst = 'h' | let b:fswitchlocs = 'include'


"nnoremap <silent> <RightMouse> :silent! Evaluate<CR>
"" nnoremap <silent> <S-RightMouse> :Break<CR>
"" let termdebugger = "tgdb"

"let termdebugger = "gdb_scl9"
"" let termdebugger = "gdb"

"" this first one works
"" nnoremap <Leader>td :TermdebugCommand %:r 
"" using this one for faster input

"" function! StartSim()
""     let command = "../socrrates/bin/start_SOCRRATES %"
"" 	execute "!" . command
"" endfunction

"function! Debug()
"    let l:command = ":term ../socrrates/bin/start_SOCRRATES %"
"	execute l:command
"endfunction

"" nnoremap <Leader>td :TermdebugCommand ./.libs/VLFaultClient -f /home/e367212/vlfc_logs_sm_sep -r VLFC:VLFC:RouterSharedData

"" vmap <leader>y ""y :call writefile(split(getreg('"',1,1), '\n'), 'vbuf')<CR>
"" vmap y y :call writefile(getreg('"',1,1), expand('$HOME/.vbuf'))<CR>
""

"nmap <leader>pp :silent! r scp://socd/~/.vbuf<CR>


"let test#preserve_screen = 1
"let test#python#pytest#executable = '/usr/bin/py.test-3'
"let test#python#runner = 'pytest'
"let test#vim#term_position = "belowright"


" let test#strategy = {
"   \ 'nearest': 'vimspector_pytest',
"   \ 'file':    'neomake',
"   \ 'suite':   'basic',
" \}

"let test#python#pytest#options = {
"  \ 'nearest': '-s --pdb',
"  \ 'file':    '-s',
"  \ 'suite':   '-s',
"\}


"nmap <leader>tn :TestNearest<CR>
"nmap <leader>tl :TestLast<CR>
"nnoremap <leader>da :TestNearest -strategy=vimspector_pytest<CR>

"if has('nvim')
"  " Terminal mode:
"  tnoremap <C-h> <c-\><c-n><c-w>h
"  tnoremap <C-j> <c-\><c-n><c-w>j
"  tnoremap <C-k> <c-\><c-n><c-w>k
"  tnoremap <C-l> <c-\><c-n><c-w>l
"endif


"" let g:neomake_python_pylint_exe = expand('$HOME/.pyenv/versions/neovim/bin/pylint')
"" let g:neomake_python_flake8_exe = expand('$HOME/.pyenv/versions/neovim/bin/flake8')

"" " which linter to enable for Python source file linting
"" let g:neomake_python_enabled_makers = ['flake8', 'pylint']
"" " let g:neomake_python_enabled_makers = ['pylint']
"" let g:neomake_python_pylint_maker = {
""   \ 'args': [
""   \ '--rcfile', expand("$PWD/pylintrc"),
""   \ '--disable', 'C0103, C0111',
""   \ '--format', 'text',
""   \ '--msg-template="{path}:{line}:{column}:{C}: [{symbol}] {msg}"',
""   \ '--report', 'n'
""   \ ],
""   \ 'errorformat':
""   \ '%A%f:%l:%c:%t: %m,' .
""   \ '%A%f:%l: %m,' .
""   \ '%A%f:(%l): %m,' .
""   \ '%-Z%p^%.%#,' .
""   \ '%-G%.%#',
""   \ }

"" let g:neomake_python_flake8_maker = {
""     \ 'args': ['--ignore=E221,E241,E272,E251,W702,E203,E201,E202',  '--format=default'],
""     \ 'errorformat':
""         \ '%E%f:%l: could not compile,%-Z%p^,' .
""         \ '%A%f:%l:%c: %t%n %m,' .
""         \ '%A%f:%l: %t%n %m,' .
""         \ '%-G%.%#',
""     \ }




"""" FORMATTING

"""""""" vim-autoformat
"let g:formatterpath = [expand('~/.pyenv/versions/neovim/bin')]
"" let g:autoformat_verbosemode=1
"let g:formatters_python = ['yapf']
"" let g:formatters_python = ['yapf', 'autopep8']
"" let g:formatters_python = ['autopep8']
"" let g:formatter_yapf_style = 'pep8'
"let g:run_all_formatters_for_python= 1

"" allow for  formatting of range
"" let g:formatdef_autopep8 = "'autopep8 - --range '.a:firstline.' '.a:lastline"
"" let g:formatters_python = ['autopep8']

"" autocmd FileType c,cpp,python nnoremap <buffer><Leader>= :<C-u>Autoformat<CR>
"" autocmd FileType c,cpp,python vnoremap <buffer>= :Autoformat<CR>

"" Looking for 'pylintrc' sitting in the root project folder
"let g:neomake_python_pylint_maker = {
"  \ 'args': [
"  \ '--format', 'text',
"  \ '--msg-template="{path}:{line}:{column}:{C}: [{symbol}] {msg}"',
"  \ '--report', 'n'
"  \ ],
"  \ 'errorformat':
"  \ '%A%f:%l:%c:%t: %m,' .
"  \ '%A%f:%l: %m,' .
"  \ '%A%f:(%l): %m,' .
"  \ '%-Z%p^%.%#,' .
"  \ '%-G%.%#',
"  \ }

"" Looking at 'setup.cfg' with header [flake8]
"let g:neomake_python_flake8_maker = {
"    \ 'args': [
"		\ '--format=default'],
"    \ 'errorformat':
"        \ '%E%f:%l: could not compile,%-Z%p^,' .
"        \ '%A%f:%l:%c: %t%n %m,' .
"        \ '%A%f:%l: %t%n %m,' .
"        \ '%-G%.%#',
"    \ }


"" Set the basic sizes
"let g:vimspector_sidebar_width = 50
"let g:vimspector_code_minwidth = 50
"let g:vimspector_terminal_minwidth = 10
"let g:vimspector_bottombar_height = 10


"" " vim: set foldmethod=marker ts=2 sw=2 tw=80 noet :

