-- NOTE: if a function is used, there has to be a name associated to it

local wk = require("which-key")
local util = require("util")

vim.opt.timeoutlen = 100
vim.opt.ttimeoutlen = 50

-- run before calling setup
local presets = require("which-key.plugins.presets")
presets.objects["a("] = nil

wk.setup {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    spelling = {
      enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    presets = {
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    ["<space>"] = "SPC",
    ["<cr>"] = "RET",
    ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  window = {
    border = "none", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 0, 0, 0, 0 }, -- extra window padding [top, right, bottom, left]
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

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
util.nnoremap("[Window]e","<cmd>enew<cr>")


-- better indenting
util.vnoremap("<", "<gv")
util.vnoremap(">", ">gv")


-- quit, record macrocs
-- util.nnoremap("q", ":<C-u>quit<CR>", {nowait = true})
util.nnoremap("Q", "q")
util.nnoremap("qQ", "@q")

-- yank to end of line
util.nmap("Y", "y$")



-- Insert
util.imap("jk", '<ESC>')
util.inoremap('<C-c>', '<esc>')
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
util.nnoremap("<localleader>Y", ':let @"=expand("%:p")<CR>:OSCYankReg "<CR>')
util.nnoremap("<localleader>YY", ':let @"=expand("%:p:h")<CR>:OSCYankReg "<CR>')
util.vnoremap('<localleader>y', ':OSCYank<CR>')

-- Tabs
util.nnoremap("L", ":tabnext<cr>")
util.nnoremap("H", ":tabprevious<cr>")



-- " Use backspace key for matching parens
util.nmap("<BS>", "%")
util.xmap("<BS>", "%")


-- -- " Quick substitute within selected area
-- util.xnoremap("sg",":s/\v/g<Left><Left>")
-- util.xnoremap("sc",":s/\v/gc<Left><Left><Left>")


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
  },

  t = {
    name = "+toggle",
    w = {
      function()
        util.toggle("wrap")
      end,
      "Word Wrap",
    },
  },
  d = {
    name = "+diff",
    d = {
      function()
        local branch  = vim.fn.input("branch > ")
        local filepath = vim.fn.expand("%")
        local exec_cmd = "DiffviewOpen ".. branch .. " -- ".. filepath
        P(exec_cmd)
        vim.cmd(exec_cmd)
      end, "Against <branch>"
    },
    r = {
      function()
        local filepath = vim.fn.expand("%")
        local exec_cmd = "DiffviewOpen HEAD~1 -- ".. filepath
        P(exec_cmd)
        vim.cmd(exec_cmd)
      end, "Against most recent"
    },
  },
  a = {"<cmd>NvimTreeFindFile<CR>", 'NvimTree File'},
  e = {"<cmd>NvimTreeToggle<CR>", 'NvimTree Toggle'},
}




-- #############


local leader = {
  d = {
    name = "+Diff",
    d = {
      function()
        local branch  = vim.fn.input("branch > ")
        local path = vim.fn.input("path > ")
        vim.cmd("DiffviewOpen ".. branch .. " -- " .. path)
      end, "DiffOpen <branch>"
    },
    o={"<cmd>DiffviewOpen<CR>", "DiffOpen"},
    m={"<cmd>DiffviewOpen master<CR>", "DiffOpen master"},
    r={"<cmd>DiffviewOpen HEAD~1<CR>", "DiffOpen HEAD~1"},
    c={"<cmd>DiffviewClose<CR>", "DiffClose"},
  },

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
    t = {"<cmd>TodoTelescope<CR>", "Telescope Todo"},
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
    g = {
      function()
        R('configs.telescope')['live_grep']()
      end,
      "Live Grep"
    },
  },
  f = {
    name = "+find",
    p = {
      function()
        R('configs.telescope')['grep_promp']()
      end,
      "Grep Prompt"
    },
    q = {
      function()
        R('configs.telescope')['grep_quickfix']()
      end,
      "Qf Grep"
    },
    g = {
      function()
        R('configs.telescope')['live_grep']()
      end,
      "Live Grep"
    },
    e = {
      function()
        R('configs.telescope')['grep_prompt_regex_filetype_add_args']()
      end,
      "RG Grep"
    },
    r = {
      function()
        R('configs.telescope')['registers']()
      end,
      "Registers"
    },
    t = {
      function()
        R('configs.telescope')['search_only_certain_files']()
      end,
      "Ft Grep"
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
  },
  ["`"] = { "<cmd>:e #<cr>", "Switch to Other Buffer" },
  [" "] = {
    function()
      R('configs.telescope')['find_files']()
    end,
    "Find File"
  },
}

for i = 0, 10 do
  leader[tostring(i)] = "which_key_ignore"
end


-- #############
util.vnoremap("<leader>*",
function()
  R('configs.telescope')['find_word']()
end
)

-- FIXME: visual mode is not working
-- local visual_opts = {
--   mode = "v", -- VISUAL mode
--   prefix = "",
--   buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
--   silent = true, -- use `silent` when creating keymaps
--   noremap = true, -- use `noremap` when creating keymaps
--   nowait = false, -- use `nowait` when creating keymaps
-- }

-- local v_leader = {
--   ["*"] = {
--     function()
--       R('configs.telescope')['find_word']()
--     end,
--     "Find Word"
--   },
-- }

-- wk.register(v_leader, { prefix = "<leader>" }, visual_opts)



wk.register(leader, { prefix = "<leader>" }, normal_opts)
wk.register(localleader, { prefix = "<localleader>" }, normal_opts)
