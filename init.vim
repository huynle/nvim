let $VIMPATH=expand('$HOME/.config/nvim')

if exists('g:vscode')
  " VSCode extension
else
  lua require('options')
  lua require "plugins"
  lua require('util.event')
  execute 'source' fnameescape($VIMPATH.'/base.vim')
endif
