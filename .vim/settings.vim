""""" Rsync
" on save
let b:enable_rsync  = 1
let b:rsync_auto_write  = 1

" VNC server
let b:rsync_server  = "etbc"
let b:rsync_remote  = "~/.config/nvim"

" DON't end with forward slash
let b:rsync_local   = "$PROJECT"
let b:rsync_exclude = ".gitignore"
let b:rsync_extra_args = "--exclude .git/"
