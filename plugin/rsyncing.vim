"""""""""""""""""""" Running rsync on save"
" if rsync project is set, then it will overrite all projects
let g:rsync_auto_write_project  = 0
let g:rsync_auto_write_file = 0
let g:rsync_enable = 0
let g:rsync_exclude_gitignore = 1
let g:rsync_exclude_git = 1

" rsync
function! RemoteSync (sync_type)
	if !exists("g:rsync_enable") || g:rsync_enable == 0
		return
	endif
	" u for Update
	" t for copying time also
	" r for recursive
  "
  " TODO to update this to automatically strip off the trailing slashes
  
  let l:rsync_base = "rsync -art"

  if g:rsync_exclude_git == 1
    let l:rsync_base = l:rsync_base . " --exclude .git/"
  endif 

  if g:rsync_exclude_gitignore == 1
    let l:rsync_base = l:rsync_base . " --exclude-from=".b:rsync_local."/.gitignore"
  endif 

  if g:rsync_exclude
    let l:rsync_base = l:rsync_base . " --exclude-from=".b:rsync_local."/".g:rsync_exclude
  endif 

  if a:sync_type == "write-file"
    let l:rsync_cmd_post = b:rsync_local."/".b:rsync_cur_file." ".g:rsync_server.":".g:rsync_remote_dir."/".b:rsync_cur_file." &"

  elseif a:sync_type == "write-project"
		let l:rsync_cmd_post = b:rsync_local."/ ".g:rsync_server.":".g:rsync_remote_dir." &"

  elseif a:sync_type == "write-project-delete"
		let l:rsync_cmd_post = b:rsync_local."/ ".g:rsync_server.":".g:rsync_remote_dir." --delete &"

  elseif a:sync_type == "read-file"
    let l:rsync_cmd_post = b:rsync_server."/".b:rsync_cur_file." ".g:rsync_local.":".g:rsync_remote_dir."/".b:rsync_cur_file." &"

	elseif a:sync_type == "read-project"
		let l:rsync_cmd_post = g:rsync_server.":".g:rsync_remote_dir."/ ".b:rsync_local." &"

	elseif a:sync_type == "read-project-delete"
		let l:rsync_cmd_post = g:rsync_server.":".g:rsync_remote_dir."/ ".b:rsync_local." --delete &"
	endif

  let total_rsync_cmd = l:rsync_base ." ". l:rsync_cmd_post

  " execute "!" . rsync_command
	execute "!" . total_rsync_cmd
	" execute "!" . rsync_command_reverse

	" turn off rsync until it is loaded again by .local.vimrc
endfunction

function! IsMaster()
  if isdirectory($PROJECT."/.git")
    " if filereadable($PROJECT."/.vim/rsync_master")
    return 1
  elseif filereadable($PROJECT."/.git")
    return 1
  endif
  return 0
endfunction

" " bind K to grep word under cursor
" nnoremap <silent> <Leader>sw :call RemoteSync("write-project")<CR>
" nnoremap <silent> <Leader>swd :call RemoteSync("write-delete")<CR>
" nnoremap <silent> <Leader>sr :call RemoteSync("read")<CR>
" nnoremap <silent> <Leader>srd :call RemoteSync("read-delete")<CR>
" nnoremap <silent> <Leader>srdd :call RemoteSync("read-delete-no-exclude")<CR>
" " au BufWritePost,FileWritePost * silent call RemoteSync()

command! RRemoteWriteFile call RemoteSync("write-file") 
command! RRemoteWriteProject call RemoteSync("write-project") 
command! RRemoteWriteProjectDelete call RemoteSync("write-project-delete") 

command! RRemoteReadFile call RemoteSync("read-file") 
command! RRemoteReadProject call RemoteSync("read-project") 
command! RRemoteReadProjectDelete call RemoteSync("read-project-delete") 

autocmd BufWritePost * if g:rsync_auto_write_project && IsMaster() | silent! call RemoteSync("write-project") | endif
autocmd BufWritePost * if g:rsync_auto_write_file && !g:rsync_auto_write_project && IsMaster() | silent! call RemoteSync("write-file") | endif

" autocmd BufWritePost * if g:rsync_auto_write_project && IsMaster() | call RemoteSync("write-project") | endif
" autocmd BufWritePost * if g:rsync_auto_write_file && !g:rsync_auto_write_project && IsMaster() | call RemoteSync("write-file") | endif
