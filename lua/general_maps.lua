local bind = require('keymap.bind')
local util = require('util')

local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd

-- default map
local def_map = {
    -- Vim map
    -- TODO: Convert this to a new  mapping that uses utils
    ["n|<C-q>"]      = map_cmd(':wq<CR>'),
    ["n|<C-x>k"]     = map_cr('bdelete'):with_noremap():with_silent(),
    ["n|<C-s>"]      = map_cu('write'):with_noremap(),
    ["n|Y"]          = map_cmd('y$'),
    ["n|]w"]         = map_cu('WhitespaceNext'):with_noremap(),
    ["n|[w"]         = map_cu('WhitespacePrev'):with_noremap(),
    ["n|F2"]         = map_cmd([[source $MYVIMRC<CR>]]):with_noremap(),


    -- quit, record macrocs
    ["n|q"]          = map_cu(':quit<CR>'):with_noremap():with_silent(),
    -- " Macros
    ["n|Q"]          = map_cmd('q'):with_noremap(),
    ["n|qQ"]          = map_cmd('@q'):with_noremap(),


    -- ["n|<C-h>"]      = map_cmd('<C-w>h'):with_noremap(),
    -- ["n|<C-l>"]      = map_cmd('<C-w>l'):with_noremap(),
    -- ["n|<C-j>"]      = map_cmd('<C-w>j'):with_noremap(),
    -- ["n|<C-k>"]      = map_cmd('<C-w>k'):with_noremap(),

    ["n|<leader>ss"] = map_cu('SessionSave'):with_noremap(),
    ["n|<leader>sl"] = map_cu('SessionLoad'):with_noremap(),

    ["n|<Down>"]     = map_cr('resize +5'):with_silent(),
    ["n|<Up>"]       = map_cr('resize -5'):with_silent(),
    ["n|<Right>"]    = map_cr('vertical resize +5'):with_silent(),
    ["n|<Left>"]     = map_cr('vertical resize -5'):with_silent(),

  -- Insert
    ["i|jk"]         = map_cmd('<ESC>'),
    ["i|<C-w>"]      = map_cmd('<C-[>diwa'):with_noremap(),
    ["i|<C-h>"]      = map_cmd('<BS>'):with_noremap(),
    ["i|<C-d>"]      = map_cmd('<Del>'):with_noremap(),
    ["i|<C-u>"]      = map_cmd('<C-G>u<C-U>'):with_noremap(),
    ["i|<C-b>"]      = map_cmd('<Left>'):with_noremap(),
    ["i|<C-f>"]      = map_cmd('<Right>'):with_noremap(),
    ["i|<C-a>"]      = map_cmd('<ESC>^i'):with_noremap(),
    ["i|<C-j>"]      = map_cmd('<Esc>o'):with_noremap(),
    ["i|<C-k>"]      = map_cmd('<Esc>O'):with_noremap(),
    ["i|<C-s>"]      = map_cmd('<Esc>:w<CR>'),
    ["i|<C-q>"]      = map_cmd('<Esc>:wq<CR>'),
    ["i|<C-e>"]      = map_cmd([[pumvisible() ? "\<C-e>" : "\<End>"]]):with_noremap():with_expr(),

  -- command line
    ["c|<C-b>"]      = map_cmd('<Left>'):with_noremap(),
    ["c|<C-f>"]      = map_cmd('<Right>'):with_noremap(),
    ["c|<C-a>"]      = map_cmd('<Home>'):with_noremap(),
    ["c|<C-e>"]      = map_cmd('<End>'):with_noremap(),
    ["c|<C-d>"]      = map_cmd('<Del>'):with_noremap(),
    ["c|<C-h>"]      = map_cmd('<BS>'):with_noremap(),
    ["c|<C-t>"]      = map_cmd([[<C-R>=expand("%:p:h") . "/" <CR>]]):with_noremap(),

    -- Yank from cursor position to end-of-line
    ['n|<localleader>Y'] = map_cmd(':let @"=expand("%:p")<CR>:OSCYankReg "<CR>'),
    ['n|<localleader>YY'] = map_cmd(':let @"=expand("%:p:h")<CR>:OSCYankReg "<CR>'),
    ['v|<localleader>y'] = map_cmd(':OSCYank<CR>'),

    -- select blocks after indent
    ["x|<"] = map_cmd("<gv"),
    ["x|>"] = map_cmd(">gv|"),

    -- Drag current line/s vertically and auto-indent
    ["v|K"] = map_cmd(":m-2<CR>gv=gv"),
    ["v|J"] = map_cmd(":m'>+<CR>gv=gv"),
    -- Tabs
    ["n|L"] = map_cu("tabnext"):with_silent(),
    ["n|H"] = map_cu("tabprevious"):with_silent(),


    -- Allow using the repeat operator with a visual selection (!)
    -- http://stackoverflow.com/a/8064607/127816
    ["v|."] = map_cmd(". :normal .<CR>"),

    -- Adding empty lines above and below current line, can also use `5[<space>` to
    -- get 5 lines added. for normal mode this is taken care by unimpaired vim
    ["v|[<space>"] =  map_cmd(":<c-u>put! =repeat(nr2char(10), v:count1)<cr>"),
    ["v|]<space>"] =  map_cmd(":<c-u>put =repeat(nr2char(10), v:count1)<cr>"),


    -- duplicate line
    ["n|<localleader>d"] = map_cmd("mzYP`z"),
    ["v|<localleader>d"] = map_cmd("YPgv"),

    -- Window-control prefix
    ["n|[Window]|"] = map_cmd("<Nop>"):with_noremap(),
    ["n|s"] = map_cmd("[Window]"),

    -- Custom window movement
    ["n|[Window]g"] = map_cmd(":<C-u>split<CR>:wincmd p<CR>:e#<CR>"):with_noremap(),
    ["n|[Window]v"] = map_cmd(":<C-u>vsplit<CR>:wincmd p<CR>:e#<CR>"):with_noremap(),
    ["n|[Window]t"] = map_cmd(":<C-u>tab split<CR>:execute tabn '.g:lasttab<CR>"):with_noremap(),
    ["n|[Window]T"] = map_cmd(":tabnew<CR>"):with_noremap(),
    ["n|[Window]o"] = map_cmd(":<C-u>only<CR>"):with_noremap(),
    ["n|[Window]b"] = map_cmd(":b#<CR>"):with_noremap(),
    ["n|[Window]c"] = map_cmd(":close<CR>"):with_noremap(),
    -- View tag in vim preview window. This is short for <c-w>}
    ["n|[Window]]"] = map_cmd("<C-w>]"):with_noremap(),
    ["n|[Window]="] = map_cmd("<C-w>="):with_noremap(),
    ["n|[Window]H"] = map_cmd("<C-w>H"):with_noremap(),
    ["n|[Window]J"] = map_cmd("<C-w>J"):with_noremap(),
    ["n|[Window]K"] = map_cmd("<C-w>K"):with_noremap(),
    ["n|[Window]L"] = map_cmd("<C-w>L"):with_noremap(),
    ["n|[Window]z"] = map_cmd("<C-w>z"):with_noremap(),


}

bind.nvim_load_mapping(def_map)


-- ========================= NEW METHOD OF MAPPING HERE
-- TODO: remap things here

-- Resize window using <ctrl> arrow keys
util.nnoremap("<S-Up>", ":resize +2<CR>")
util.nnoremap("<S-Down>", ":resize -2<CR>")
util.nnoremap("<S-Left>", ":vertical resize -2<CR>")
util.nnoremap("<S-Right>", ":vertical resize +2<CR>")

-- terminal map
util.tnoremap('<C-w><C-o>' , '<C-\\><C-n> :MaximizerToggle!<CR>')
util.tnoremap('<C-h>'      , '<C-\\><C-n><C-w>h')
util.tnoremap('<C-j>'      , '<C-\\><C-n><C-w>j')
util.tnoremap('<C-k>'      , '<C-\\><C-n><C-w>k')
util.tnoremap('<C-l>'      , '<C-\\><C-n><C-w>l')
-- much better to exit, since you could be in a nvim terminal inside the
-- terminal
util.tnoremap('<A-j><A-k>'         , '<C-\\><C-n>')

-- Clear search with <esc>
util.map("", "<esc>", ":noh<cr>")
util.nnoremap("gw", "*N")
util.xnoremap("gw", "*N")

-- Move Lines
util.nnoremap("<A-j>", ":m .+1<CR>==")
util.vnoremap("<A-j>", ":m '>+1<CR>gv=gv")
util.inoremap("<A-j>", "<Esc>:m .+1<CR>==gi")
util.nnoremap("<A-k>", ":m .-2<CR>==")
util.vnoremap("<A-k>", ":m '<-2<CR>gv=gv")
util.inoremap("<A-k>", "<Esc>:m .-2<CR>==gi")

-- better indenting
util.vnoremap("<", "<gv")
util.vnoremap(">", ">gv")


-- makes * and # work on visual mode too.
vim.api.nvim_exec(
  [[
  function! g:VSetSearch(cmdtype)
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
    let @s = temp
  endfunction

  xnoremap * :<C-u>call g:VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
  xnoremap # :<C-u>call g:VSetSearch('?')<CR>?<C-R>=@/<CR><CR>
]],
  false
)
