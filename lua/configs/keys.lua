local wk = require("which-key")
local util = require("util")

vim.opt.timeoutlen = 200
vim.opt.ttimeoutlen    = 50;

local presets = require("which-key.plugins.presets")
presets.objects["a("] = nil

wk.setup({ show_help = false, triggers = "auto", plugins = { spelling = true }, key_labels = { ["<leader>"] = "SPC" } })

-- Adding empty lines above and below current line, can also use `5[<space>` to
-- get 5 lines added. for normal mode this is taken care by unimpaired vim
util.vmap("[<space>", ":<c-u>put! =repeat(nr2char(10), v:count1)<cr>")
util.vmap("]<space>", ":<c-u>put =repeat(nr2char(10), v:count1)<cr>")

-- Resize window using <ctrl> arrow keys
util.nnoremap("<S-Up>", ":resize +4<CR>")
util.nnoremap("<S-Down>", ":resize -4<CR>")
util.nnoremap("<S-Left>", ":vertical resize -4<CR>")
util.nnoremap("<S-Right>", ":vertical resize +4<CR>")


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


-- INFO: removed window to use lightspeed
-- Window-control prefix
-- util.nnoremap("[Window]", "<Nop>")
-- util.nmap("s", "[Window]")
-- -- Custom window movement
-- util.nnoremap("[Window]g",":<C-u>split<CR>:wincmd p<CR>:e#<CR>")
-- util.nnoremap("[Window]v",":<C-u>vsplit<CR>:wincmd p<CR>:e#<CR>")
-- util.nnoremap("[Window]t",":<C-u>tab split<CR>:execute tabn '.g:lasttab<CR>")
-- util.nnoremap("[Window]T",":tabnew<CR>")
-- util.nnoremap("[Window]o",":<C-u>only<CR>")
-- util.nnoremap("[Window]b",":b#<CR>")
-- util.nnoremap("[Window]c",":close<CR>")
-- util.nnoremap("[Window]]","<C-w>]")
-- util.nnoremap("[Window]=","<C-w>=")
-- util.nnoremap("[Window]H","<C-w>H")
-- util.nnoremap("[Window]J","<C-w>J")
-- util.nnoremap("[Window]K","<C-w>K")
-- util.nnoremap("[Window]L","<C-w>L")
-- util.nnoremap("[Window]z","<C-w>z")
-- util.nnoremap("[Window]e","<cmd>enew<cr>")


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

local normal_opts = {
  mode = "n", -- NORMAL mode
  -- prefix: use "<leader>f" for example for mapping everything related to finding files
  -- the prefix is prepended to every mapping part of `mappings`
  prefix = "", 
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

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
  g = {
    name = "+git",
    s = { "<cmd>Neogit<CR>", "NeoGit" },
    -- s = { "<Cmd>Telescope git_status<CR>", "status" },
    c = { "<Cmd>Telescope git_commits<CR>", "commits" },
    b = { "<Cmd>Telescope git_branches<CR>", "branches" },
    d = { "<cmd>DiffviewOpen<cr>", "DiffView" },
    h = { name = "+hunk" },
  },
  f = {
    name = "+find",
    p = {
      function()
        R('configs.telescope')['grep_promp']()
      end
    },
    --   -- map_tele("v", "<Leader>gg", "grep_prompt_visual")
    q = {
      function()
        R('configs.telescope')['grep_quickfix']()
      end,
    },
    g = {
      function()
        R('configs.telescope')['live_grep']()
      end,
    },
    e = {
      function()
        R('configs.telescope')['grep_prompt_regex_filetype_add_args']()
      end
    },
    r = {
      function()
        R('configs.telescope')['registers']()
      end
    },
    t = {
      function()
        R('configs.telescope')['search_only_certain_files']()
      end
    },
    f = {
      function()
        R('configs.telescope')['find_files']()
      end,
      "Find Files"
    },
  },

-- map_tele("v", "<Leader>G", "grep_prompt_regex_filetype")
  x = {
    name = "+errors",
    x = { "<cmd>TroubleToggle<cr>", "Trouble" },
    w = { "<cmd>TroubleWorkspaceToggle<cr>", "Workspace Trouble" },
    d = { "<cmd>TroubleDocumentToggle<cr>", "Document Trouble" },
    t = { "<cmd>TodoTrouble<cr>", "Todo Trouble" },
    T = { "<cmd>TodoTelescope<cr>", "Todo Telescope" },
    l = { "<cmd>lopen<cr>", "Open Location List" },
    q = { "<cmd>copen<cr>", "Open Quickfix List" },
  },

  ["h"] = {
    name = "+help",
    t = { "<cmd>:Telescope builtin<cr>", "Telescope" },
    c = { "<cmd>:Telescope commands<cr>", "Commands" },
    h = { "<cmd>:Telescope help_tags<cr>", "Help Pages" },
    m = { "<cmd>:Telescope man_pages<cr>", "Man Pages" },
    k = { "<cmd>:Telescope keymaps<cr>", "Key Maps" },
    s = { "<cmd>:Telescope highlights<cr>", "Search Highlight Groups" },
    f = { "<cmd>:Telescope filetypes<cr>", "File Types" },
    o = { "<cmd>:Telescope vim_options<cr>", "Options" },
    a = { "<cmd>:Telescope autocommands<cr>", "Auto Commands" },
  },

  ["`"] = { "<cmd>:e #<cr>", "Switch to Other Buffer" },
  [" "] = {
    function()
      R('configs.telescope')['find_files']()
    end,
    "Find File"
  },


  --
  ["c"] = {
    name = "configs",
    n = {
      function()
        R('configs.telescope')['edit_neovim']()
      end,
      "Edit Nvim"
    },
    d = {
      function()
        R('configs.telescope')['edit_dotfiles']()
      end,
      "Edit Dotfiles"
    },
  },
  ["."] = { ":Telescope file_browser<CR>", "Browse Files" },
  [","] = { "<cmd>Telescope buffers show_all_buffers=true<cr>", "Switch Buffer" },
  ["/"] = { "<cmd>Telescope live_grep<cr>", "Search" },
  [":"] = { "<cmd>Telescope command_history<cr>", "Command History" },
  ["*"] = {
      function()
        R('configs.telescope')['find_word']()
      end,
      "Find Word"

  }
}

for i = 0, 10 do
  leader[tostring(i)] = "which_key_ignore"
end

wk.register(leader, { prefix = "<leader>" }, normal_opts)
wk.register(localleader, { prefix = "<localleader>" }, normal_opts)
