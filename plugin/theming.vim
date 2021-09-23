" " ChangeBackground changes the background mode based on macOS's `Appearance`
" " setting. We also refresh the statusline colors to reflect the new mode.
" function! ChangeBackground()
"   if system("defaults read -g AppleInterfaceStyle") =~ '^Dark'
"   " if 0
"     " lua require('material.functions').change_style('deep ocean')
"     let g:material_style = "deep ocean"
"     colorscheme material
"     set background=dark   " for the dark version of the theme
"   else
"     " lua require('material.functions').change_style('lighter')
"     let g:material_style = "lighter"
"     colorscheme material
"     set background=light  " for the light version of the theme
"   endif

"   " try
"   "   execute "AirlineRefresh"
"   " catch
"   " endtry
" endfunction

" initialize the colorscheme for the first run
" call ChangeBackground()

" " change the color scheme if we receive a SigUSR1
" autocmd SigUSR1 * call ChangeBackground()
"
"


" COLORSCHEME NAME
let g:themefile = g:vimcache.'theme.txt'
let g:default_theme = 'material'
let g:default_bg = 'dark'
let g:default_material_style = "deep ocean"

function! SetColors()
  " if ! exists('g:colors_name')
    " echom "got colorschem: " . readfile(g:themefile)[0]
    " echom "got bg" . readfile(g:themefile)[1]
    execute printf("let g:material_style='%s'", (filereadable(g:themefile) ? readfile(g:themefile)[0] : g:default_material_style))
    execute printf("colorscheme %s", filereadable(g:themefile) ? readfile(g:themefile)[1] : g:default_theme)
    execute printf("set background=%s",(filereadable(g:themefile) ? readfile(g:themefile)[2] : g:default_bg))
    " execute g:test1
    " execute g:test2
    " execute g:test3
  " endif
endfunction

" function! s:theme_write(color_info, filepath)
"   call writefile(a:color_info, a:filepath)
" endfunction

" function! s:reloadBackground()
        " let l:saved_bg = filereadable(g:themefile) ? readfile(g:themefile)[1] : 'dark'
        " if l:saved_bg != &background
                " call s:setColors()
        " endif
" endfunction


function! ToggleBg()
  if &background ==? 'dark'
    call writefile(["lighter", "material", "light"], g:themefile)
    call SetColors()
    " execute "silent !tmux source-file " . shellescape(expand('~/.tmux/themes/huy-light.sh'))
  else
    call writefile(["deep ocean", "material", "dark"], g:themefile)
    call SetColors()
    " execute "silent !tmux source-file " . shellescape(expand('~/.tmux/themes/huy-dark.sh'))
  endif
  " trigger all over vim processes


endfunction

command! ToggleBackground call ToggleBg()

" ReloadBackground
nnoremap <silent><Leader>bg :<C-u>call ToggleBg()<CR>

" " THEME NAME
" if filereadable(g:themefile)
"   call s:setColors()
" endif

