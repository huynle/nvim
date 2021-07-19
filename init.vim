let $VIMPATH=expand('$HOME/.config/nvim')

if exists('g:vscode')
  " VSCode extension
else
  lua require('init')
  execute 'source' fnameescape($VIMPATH.'/base.vim')
endif
