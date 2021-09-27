" COLORSCHEME NAME
" inspiration from here: https://arslan.io/2021/02/15/automatic-dark-mode-for-terminal-applications/
let g:themefile = g:vimcache.'theme.txt'
let g:default_theme = 'material'
let g:default_bg = 'dark'
let g:default_material_style = "deep ocean"

function! SetColors()
    execute printf("let g:material_style='%s'", (filereadable(g:themefile) ? readfile(g:themefile)[0] : g:default_material_style))
    execute printf("colorscheme %s", filereadable(g:themefile) ? readfile(g:themefile)[1] : g:default_theme)
    execute printf("set background=%s",(filereadable(g:themefile) ? readfile(g:themefile)[2] : g:default_bg))
endfunction

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
  " lua require('plenary.reload').reload_module('lualine.nvim', true)
endfunction

command! ToggleBackground call ToggleBg()

nnoremap <silent><Leader>bg :<C-u>call ToggleBg()<CR>:execute printf("!bash -c togglebg")<CR>
