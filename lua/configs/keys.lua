local wk = require("which-key")
local util = require("util")

vim.opt.timeoutlen = 200
vim.opt.ttimeoutlen    = 50;

local presets = require("which-key.plugins.presets")
presets.objects["a("] = nil

wk.setup({ show_help = false, triggers = "auto", plugins = { spelling = true }, key_labels = { ["<leader>"] = "SPC" } })

util.nmap("<C-q>",':wq<CR>')

-- Adding empty lines above and below current line, can also use `5[<space>` to
-- get 5 lines added. for normal mode this is taken care by unimpaired vim
util.vmap("[<space>", ":<c-u>put! =repeat(nr2char(10), v:count1)<cr>")
util.vmap("]<space>", ":<c-u>put =repeat(nr2char(10), v:count1)<cr>")

-- Resize window using <ctrl> arrow keys
util.nnoremap("<S-Up>", ":resize +2<CR>")
util.nnoremap("<S-Down>", ":resize -2<CR>")
util.nnoremap("<S-Left>", ":vertical resize -2<CR>")
util.nnoremap("<S-Right>", ":vertical resize +2<CR>")

-- Allow using the repeat operator with a visual selection (!)
-- http://stackoverflow.com/a/8064607/127816
util.vmap(".", ". :normal .<CR>")

-- much better to exit, since you could be in a nvim terminal inside the
-- terminal
util.tnoremap('<A-j><A-k>', '<C-\\><C-n>')

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

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
util.nnoremap("n", "'Nn'[v:searchforward]", { expr = true })
util.xnoremap("n", "'Nn'[v:searchforward]", { expr = true })
util.onoremap("n", "'Nn'[v:searchforward]", { expr = true })
util.nnoremap("N", "'nN'[v:searchforward]", { expr = true })
util.xnoremap("N", "'nN'[v:searchforward]", { expr = true })
util.onoremap("N", "'nN'[v:searchforward]", { expr = true })

-- Window-control prefix
util.nnoremap("[Window]", "<Nop>")
util.nmap("s", "[Window]")

-- Custom window movement
util.nnoremap("[Window]g",":<C-u>split<CR>:wincmd p<CR>:e#<CR>")
util.nnoremap("[Window]v",":<C-u>vsplit<CR>:wincmd p<CR>:e#<CR>")
util.nnoremap("[Window]t",":<C-u>tab split<CR>:execute tabn '.g:lasttab<CR>")
util.nnoremap("[Window]T",":tabnew<CR>")
util.nnoremap("[Window]o",":<C-u>only<CR>")
util.nnoremap("[Window]b",":b#<CR>")
util.nnoremap("[Window]c",":close<CR>")
util.nnoremap("[Window]]","<C-w>]")
util.nnoremap("[Window]=","<C-w>=")
util.nnoremap("[Window]H","<C-w>H")
util.nnoremap("[Window]J","<C-w>J")
util.nnoremap("[Window]K","<C-w>K")
util.nnoremap("[Window]L","<C-w>L")
util.nnoremap("[Window]z","<C-w>z")
util.nnoremap("[Window]e","<cmd>enew<cr>")


-- better indenting
util.vnoremap("<", "<gv")
util.vnoremap(">", ">gv")


-- quit, record macrocs
util.nnoremap("q", "<C-u>:quit<CR>")
util.nnoremap("Q", "q")
util.nnoremap("qQ", "@q")

-- yank to end of line
util.nmap("Y", "y$")



-- Insert
util.imap("jk", '<ESC>')
util.inoremap("<C-w>", '<C-[>diwa')
util.inoremap("<C-h>", '<BS>')
util.inoremap("<C-d>", '<Del>')
util.inoremap("<C-u>", '<C-G>u<C-U>')
util.inoremap("<C-b>", '<Left>')
util.inoremap("<C-f>", '<Right>')
util.inoremap("<C-a>", '<ESC>^i')
util.inoremap("<C-j>", '<Esc>o')
util.inoremap("<C-k>", '<Esc>O')
util.inoremap("<C-e>", [[pumvisible() ? "\<C-e>" : "\<End>"]], {expr = true})


-- command line
util.cnoremap("<C-b>", '<Left>')
util.cnoremap("<C-f>", '<Right>')
util.cnoremap("<C-a>", '<Home>')
util.cnoremap("<C-e>", '<End>')
util.cnoremap("<C-d>", '<Del>')
util.cnoremap("<C-h>", '<BS>')
util.cnoremap("<C-t>", [[<C-R>=expand("%:p:h") . "/" <CR>]])

-- -- Yank from cursor position to end-of-line
-- util.nnoremap("<localleader>Y", ':let @"=expand("%:p")<CR>:OSCYankReg "<CR>')
-- util.nnoremap("<localleader>YY", ':let @"=expand("%:p:h")<CR>:OSCYankReg "<CR>')
util.vnoremap('<localleader>y', ':OSCYank<CR>')

-- Tabs
util.nnoremap("L", ":tabnext<cr>")
util.nnoremap("H", ":tabprevious<cr>")



-- " Use backspace key for matching parens
util.nmap("<BS>", "%")
util.xmap("<BS>", "%")



-- " Quick substitute within selected area
util.xnoremap("sg",":s/\v/g<Left><Left>")
util.xnoremap("sc",":s/\v/gc<Left><Left><Left>")


-- " C-r: Easier search and replace visual/select mode
util.xnoremap("<C-r>",[[:<C-u>%s/\V<C-R>=<SID>get_selection()<CR>//gc<Left><Left><Left>]])

-- " Start an external command with a single bang
util.nnoremap("!",":!")

-- " Put vim command output into buffer
util.nnoremap("g!",":<C-u>put=execute('')<Left><Left>")


-- " Select last paste
util.nnoremap("gp", [[`['.strpart(getregtype(), 0,","1).'`]']], {expr = true})

-- " Remove spaces at the end of lines
util.nnoremap("<localleader>cw", [[:<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>]])


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



local localleader = {
  l = {
    name = "+LSP",
    i = {"<cmd>LspInfo<CR>", "LspInfo"},
    l = {"<cmd>LspLog<CR>", "LspLog"},
    r = {"<cmd>LspRestart<CR>", "LspRestart"}
  },
  t = {"<cmd>Template<CR>"},
  y = {
    name = "+yanking",
    f = {':let @"=expand("%:p")<CR>:OSCYankReg "<CR>', "File Path"},
    p = {':let @"=expand("%:p:h")<CR>:OSCYankReg "<CR>', "Dir Path"},
  },
  c = {
    name = "+clear",
    w = {[[:<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>]], "Clear empty space"},
  }
}

local leader = {
  a = {"<cmd>:NvimTreeFindFile<CR>", 'NvimTree File'},
  e = {"<cmd>:NvimTreeToggle<CR>", 'NvimTree Toggle'},
  p = {
    name = "+Packer",
    p = { "<cmd>PackerSync<cr>", "Sync" },
    s = { "<cmd>PackerStatus<cr>", "Status" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    c = { "<cmd>PackerCompile<cr>", "Compile" },
  },
  S = {"<cmd>Scratch<CR>", "Scratch Pad"},
  R = {"<cmd>:source $MYVIMRC<CR>"},
  t = {
    name = "+toggle",
    o = {"<cmd>SymbolsOutline<CR>", "SymbolOutline"},
    d = {'<cmd>DBUIToggle<CR>', "DadbodUI"},
    m = {"<cmd>MarkdownPreview<CR>", 'MarkdownPreview'},
    f = {
      require("configs.lspconfig.formatting").toggle,
      "Format on Save",
    },
    s = {
      function()
        util.toggle("spell")
      end,
      "Spelling",
    },
    w = {
      function()
        util.toggle("wrap")
      end,
      "Word Wrap",
    },
    n = {
      function()
        util.toggle("relativenumber", true)
        util.toggle("number")
      end,
      "Line Numbers",
    },
  },
  x = {
    name = "+errors",
    x = { "<cmd>TroubleToggle<cr>", "Trouble" },
    w = { "<cmd>TroubleWorkspaceToggle<cr>", "Workspace Trouble" },
    d = { "<cmd>TroubleDocumentToggle<cr>", "Document Trouble" },
    t = { "<cmd>TodoTrouble<cr>", "Todo Trouble" },
    T = { "<cmd>TodoTelescope<cr>", "Todo Telescope" },
    l = { "<cmd>lopen<cr>", "Open Location List" },
    q = { "<cmd>copen<cr>", "Open Quickfix List" },
  }

--   t = {
--     name = "toggle",
}

-- local leader = {
--   ["w"] = {
--     name = "+windows",
--     ["w"] = { "<C-W>p", "other-window" },
--     ["d"] = { "<C-W>c", "delete-window" },
--     ["-"] = { "<C-W>s", "split-window-below" },
--     ["|"] = { "<C-W>v", "split-window-right" },
--     ["2"] = { "<C-W>v", "layout-double-columns" },
--     ["h"] = { "<C-W>h", "window-left" },
--     ["j"] = { "<C-W>j", "window-below" },
--     ["l"] = { "<C-W>l", "window-right" },
--     ["k"] = { "<C-W>k", "window-up" },
--     ["H"] = { "<C-W>5<", "expand-window-left" },
--     ["J"] = { ":resize +5", "expand-window-below" },
--     ["L"] = { "<C-W>5>", "expand-window-right" },
--     ["K"] = { ":resize -5", "expand-window-up" },
--     ["="] = { "<C-W>=", "balance-window" },
--     ["s"] = { "<C-W>s", "split-window-below" },
--     ["v"] = { "<C-W>v", "split-window-right" },
--   },
--   c = { v = { "<cmd>Vista!!<CR>", "Vista" }, o = { "<cmd>SymbolsOutline<cr>", "Symbols Outline" } },
--   b = {
--     name = "+buffer",
--     ["b"] = { "<cmd>:e #<cr>", "Switch to Other Buffer" },
--     ["p"] = { "<cmd>:BufferLineCyclePrev<CR>", "Previous Buffer" },
--     ["["] = { "<cmd>:BufferLineCyclePrev<CR>", "Previous Buffer" },
--     ["n"] = { "<cmd>:BufferLineCycleNext<CR>", "Next Buffer" },
--     ["]"] = { "<cmd>:BufferLineCycleNext<CR>", "Next Buffer" },
--     ["d"] = { "<cmd>:bd<CR>", "Delete Buffer" },
--     ["g"] = { "<cmd>:BufferLinePick<CR>", "Goto Buffer" },
--   },
--   g = {
--     name = "+git",
--     g = { "<cmd>Neogit<CR>", "NeoGit" },
--     l = {
--       function()
--         require("util").float_terminal("lazygit")
--       end,
--       "LazyGit",
--     },
--     c = { "<Cmd>Telescope git_commits<CR>", "commits" },
--     b = { "<Cmd>Telescope git_branches<CR>", "branches" },
--     s = { "<Cmd>Telescope git_status<CR>", "status" },
--     d = { "<cmd>DiffviewOpen<cr>", "DiffView" },
--     h = { name = "+hunk" },
--   },
--   ["h"] = {
--     name = "+help",
--     t = { "<cmd>:Telescope builtin<cr>", "Telescope" },
--     c = { "<cmd>:Telescope commands<cr>", "Commands" },
--     h = { "<cmd>:Telescope help_tags<cr>", "Help Pages" },
--     m = { "<cmd>:Telescope man_pages<cr>", "Man Pages" },
--     k = { "<cmd>:Telescope keymaps<cr>", "Key Maps" },
--     s = { "<cmd>:Telescope highlights<cr>", "Search Highlight Groups" },
--     l = { [[<cmd>TSHighlightCapturesUnderCursor<cr>]], "Highlight Groups at cursor" },
--     f = { "<cmd>:Telescope filetypes<cr>", "File Types" },
--     o = { "<cmd>:Telescope vim_options<cr>", "Options" },
--     a = { "<cmd>:Telescope autocommands<cr>", "Auto Commands" },
--     p = {
--       name = "+packer",
--       p = { "<cmd>PackerSync<cr>", "Sync" },
--       s = { "<cmd>PackerStatus<cr>", "Status" },
--       i = { "<cmd>PackerInstall<cr>", "Install" },
--       c = { "<cmd>PackerCompile<cr>", "Compile" },
--     },
--   },
--   u = { "<cmd>UndotreeToggle<CR>", "Undo Tree" },
--   s = {
--     name = "+search",
--     g = { "<cmd>Telescope live_grep<cr>", "Grep" },
--     b = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Buffer" },
--     s = {
--       function()
--         require("telescope.builtin").lsp_document_symbols({
--           symbols = { "Class", "Function", "Method", "Constructor", "Interface", "Module" },
--         })
--       end,
--       "Goto Symbol",
--     },
--     h = { "<cmd>Telescope command_history<cr>", "Command History" },
--     m = { "<cmd>Telescope marks<cr>", "Jump to Mark" },
--     r = { "<cmd>lua require('spectre').open()<CR>", "Replace (Spectre)" },
--   },
--   f = {
--     name = "+file",
--     t = { "<cmd>NvimTreeToggle<cr>", "NvimTree" },
--     f = { "<cmd>Telescope find_files<cr>", "Find File" },
--     r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
--     n = { "<cmd>enew<cr>", "New File" },
--     z = "Zoxide",
--     d = "Dot Files",
--   },
--   o = {
--     name = "+open",
--     p = { "<cmd>MarkdownPreview<cr>", "Markdown Preview" },
--     g = { "<cmd>Glow<cr>", "Markdown Glow" },
--   },
--   p = {
--     name = "+project",
--     p = "Open Project",
--     b = { ":Telescope file_browser cwd=~/projects<CR>", "Browse ~/projects" },
--   },
--   t = {
--     name = "toggle",
--     f = {
--       require("config.lsp.formatting").toggle,
--       "Format on Save",
--     },
--     s = {
--       function()
--         util.toggle("spell")
--       end,
--       "Spelling",
--     },
--     w = {
--       function()
--         util.toggle("wrap")
--       end,
--       "Word Wrap",
--     },
--     n = {
--       function()
--         util.toggle("relativenumber", true)
--         util.toggle("number")
--       end,
--       "Line Numbers",
--     },
--   },
--   ["<tab>"] = {
--     name = "workspace",
--     ["<tab>"] = { "<cmd>tabnew<CR>", "New Tab" },

--     n = { "<cmd>tabnext<CR>", "Next" },
--     d = { "<cmd>tabclose<CR>", "Close" },
--     p = { "<cmd>tabprevious<CR>", "Previous" },
--     ["]"] = { "<cmd>tabnext<CR>", "Next" },
--     ["["] = { "<cmd>tabprevious<CR>", "Previous" },
--     f = { "<cmd>tabfirst<CR>", "First" },
--     l = { "<cmd>tablast<CR>", "Last" },
--   },
--   ["`"] = { "<cmd>:e #<cr>", "Switch to Other Buffer" },
--   [" "] = "Find File",
--   ["."] = { ":Telescope file_browser<CR>", "Browse Files" },
--   [","] = { "<cmd>Telescope buffers show_all_buffers=true<cr>", "Switch Buffer" },
--   ["/"] = { "<cmd>Telescope live_grep<cr>", "Search" },
--   [":"] = { "<cmd>Telescope command_history<cr>", "Command History" },
--   q = {
--     name = "+quit/session",
--     q = { "<cmd>:qa<cr>", "Quit" },
--     ["!"] = { "<cmd>:qa!<cr>", "Quit without saving" },
--     s = { [[<cmd>lua require("persistence").load()<cr>]], "Restore Session" },
--     l = { [[<cmd>lua require("persistence").load({last=true})<cr>]], "Restore Last Session" },
--     d = { [[<cmd>lua require("persistence").stop()<cr>]], "Stop Current Session" },
--   },
--   Z = { [[<cmd>lua require("zen-mode").reset()<cr>]], "Zen Mode" },
--   z = { [[<cmd>ZenMode<cr>]], "Zen Mode" },
--   T = { [[<Plug>PlenaryTestFile]], "Plenary Test" },
--   D = {
--     function()
--       util.docs()
--     end,
--     "Create Docs from README.md",
--   },
-- }

for i = 0, 10 do
  leader[tostring(i)] = "which_key_ignore"
end

wk.register(leader, { prefix = "<leader>" })
wk.register(localleader, { prefix = "<localleader>" })
wk.register({ g = { name = "+goto", h = "Hop Word" }, s = "Hop Word1" })
