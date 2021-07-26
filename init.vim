let $VIMPATH=expand('$HOME/.config/nvim')

if exists('g:vscode')
  " VSCode extension
else
  lua require('options')
  lua require "util.globals"
  lua require "plugins"
  lua require('general_maps')
  lua require('keymap')
  lua require('event')
  execute 'source' fnameescape($VIMPATH.'/base.vim')
endif
