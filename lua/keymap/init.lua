local bind = require('keymap.bind')
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_args = bind.map_args
require('keymap.config')

local plug_map               = {
    ["i|<TAB>"]              = map_cmd('v:lua.tab_complete()'):with_expr():with_silent(),
    ["i|<S-TAB>"]            = map_cmd('v:lua.s_tab_complete()'):with_silent():with_expr(),
--     ["i|<CR>"]               = map_cmd([[compe#confirm({ 'keys': "\<Plug>delimitMateCR", 'mode': '' })]]):with_noremap():with_expr():with_nowait(),

    -- person keymap
    ["n|mf"]                 = map_cr("<cmd>lua require('internal.fsevent').file_event()<CR>"):with_silent():with_nowait():with_noremap();
    ["n|gb"]                 = map_cr("BufferLinePick"):with_noremap():with_silent(),

    -- Packer
    ["n|<Leader>pu"]         = map_cr("PackerUpdate"):with_noremap():with_nowait();
    ["n|<Leader>pi"]         = map_cr("PackerInstall"):with_noremap():with_nowait();
    ["n|<Leader>pc"]         = map_cr("PackerCompile"):with_noremap():with_nowait();

    -- Lsp mapp work when insertenter and lsp start
    ["n|<localleader>li"]         = map_cr("LspInfo"):with_noremap():with_silent():with_nowait(),
    ["n|<localleader>ll"]         = map_cr("LspLog"):with_noremap():with_silent():with_nowait(),
    ["n|<localleader>lr"]         = map_cr("LspRestart"):with_noremap():with_silent():with_nowait(),
    ["n|<C-f>"]              = map_cmd("<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>"):with_silent():with_noremap():with_nowait(),
    ["n|<C-b>"]              = map_cmd("<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>"):with_silent():with_noremap():with_nowait(),
    ["n|]e"]                 = map_cr('Lspsaga diagnostic_jump_next'):with_noremap():with_silent(),
    ["n|[e"]                 = map_cr('Lspsaga diagnostic_jump_prev'):with_noremap():with_silent(),
    ["n|K"]                  = map_cr("Lspsaga hover_doc"):with_noremap():with_silent(),
    ["n|<localleader>a"]                 = map_cr("Lspsaga code_action"):with_noremap():with_silent(),
    ["v|<localleader>a"]                 = map_cu("Lspsaga range_code_action"):with_noremap():with_silent(),
    ["n|gd"]                 = map_cr('Lspsaga preview_definition'):with_noremap():with_silent(),
    ["n|gD"]                 = map_cmd("<cmd>lua vim.lsp.buf.implementation()<CR>"):with_noremap():with_silent(),
    ["n|,s"]                 = map_cr('Lspsaga signature_help'):with_noremap():with_silent(),
    ["n|rn"]                 = map_cr('Lspsaga rename'):with_noremap():with_silent(),
    ["n|<localleader>f"]                 = map_cr('Lspsaga lsp_finder'):with_noremap():with_silent(),
    ["n|gt"]                 = map_cmd("<cmd>lua vim.lsp.buf.type_definition()<CR>"):with_noremap():with_silent(),
    ["n|<localleader>s"]          = map_cmd("<cmd>lua vim.lsp.buf.workspace_symbol()<CR>"):with_noremap():with_silent(),
    ["n|<localleader>e"]          = map_cr('Lspsaga show_line_diagnostics'):with_noremap():with_silent(),
    ["n|<localleader>ct"]         = map_args("Template"),
    --
    -- Plugin nvim-tree
    ["n|<Leader>e"]     = map_cr('NvimTreeToggle'):with_noremap():with_silent(),
    ["n|<Leader>ee"]     = map_cr('NvimTreeFindFile'):with_noremap():with_silent(),


    ["n|<Leader>S"]     = map_cr('Scratch'):with_noremap():with_silent(),

    -- Plugin MarkdownPreview
    ["n|<localleader>om"]         = map_cu('MarkdownPreview'):with_noremap():with_silent(),

    -- Plugin DadbodUI
    ["n|<localleader>od"]         = map_cr('DBUIToggle'):with_noremap():with_silent(),

    -- Plugin Floaterm
    -- ["n|<C-t>"]              = map_cu('Lspsaga open_floaterm'):with_noremap():with_silent(),
    -- ["t|<C-t>"]              = map_cu([[<C-\><C-n>:Lspsaga close_floaterm<CR>]]):with_noremap():with_silent(),

    -- Far.vim
    ["n|<localleader>fz"]         = map_cr('Farf'):with_noremap():with_silent();
    ["v|<localleader>fz"]         = map_cr('Farf'):with_noremap():with_silent();


    -- -- neogit.vim
    -- ["n|<leader>gs"]         = map_cr('Neogit'):with_noremap():with_silent();
    -- ["n|<leader>gc"]         = map_cr('Neogit commit'):with_noremap():with_silent();

    -- Plugin Telescope
--     ["n|<Leader>b"]     = map_cu('Telescope buffers'):with_noremap():with_silent(),
--     ["n|<Leader>g"]  = map_cu('Telescope live_grep'):with_noremap():with_silent(),
--     ["n|<Leader>g"]     = map_cu([[:lua require('telescope').extensions.fzf_writer.grep()]]):with_noremap():with_silent(),
    -- ["v|<Leader>g"]     = map_cu([[Telescope grep_string]]):with_noremap():with_silent(),
    -- ["n|<localleader>fb"]      = map_cu('Telescope file_browser'):with_noremap():with_silent(),
--     ["n|<Leader>f"]  = map_cu('Telescope git_files'):with_noremap():with_silent(),
    -- ["n|<Leader>f"]  = map_cu('Telescope find_files'):with_noremap():with_silent(),
--     ["n|<Leader>f"]     = map_cu([[:lua require('telescope').extensions.fzf_writer.files()]]):with_noremap():with_silent(),
    -- ["n|<Leader>fq"]    = map_cu('Telescope quickfix'):with_noremap():with_silent(),
    -- ["n|<Leader>d"]     = map_cmd([[:lua require 'telescope.builtin'.find_files({prompt_title = "dotfiles", cwd = "$HOME/.dotfiles"})<CR>]]):with_noremap(),


--     ["n|<Leader>gw"] = map_cmd(':<C-u>Telescope grep_string default_text=<C-r>=shellescape(<SID>get_selection(), 1)<CR><CR>'),

--     ["n|<Leader>fd"] = map_cu('Telescope dotfiles path='..os.getenv("HOME")..'/.dotfiles'):with_noremap():with_silent(),
--     ["n|<Leader>fd"] = map_cmd('Telescope dotfiles path='..os.getenv("HOME")..'/.dotfiles'):with_noremap():with_silent(),
--     ["n|<Leader>fd"] = map_cmd(":lua require'internal.dotfiles'.search_dotfiles()"):with_noremap(),
--     ["n|<Leader>fd"] = require "telescope.builtin".find_files({prompt_title = "dotfiles ", cwd = "$HOME/.dotfiles"}),

    -- ["n|<Leader>hh"]    = map_cu('Telescope help_tags'):with_noremap():with_silent(),
    -- ["n|<Leader>hm"]    = map_cu('Telescope keymaps'):with_noremap():with_silent(),
    -- ["n|<Leader>hc"]    = map_cu('Telescope commands'):with_noremap():with_silent(),

    -- ["n|<Leader>gc"]    = map_cu('Telescope git_commits'):with_noremap():with_silent(),

    -- ["n|<localleader>g"]          = map_cu('Telescope current_buffer_fuzzy_find'):with_noremap():with_silent(),
    -- ["n|<localleader>fl"]         = map_cu('Telescope loclist'):with_noremap():with_silent(),

    -- -- prodoc
    -- ["n|<localleader>v"]          = map_cu('ProComment'):with_noremap():with_silent(),
    -- ["x|<localleader>v"]          = map_cr('ProComment'),
    -- ["n|gcj"]                = map_cu('ProDoc'):with_silent():with_silent(),

   -- Plugin acceleratedjk
--     ["n|j"]               = map_cmd('v:lua.enhance_jk_move("j")'):with_silent():with_expr(),
--     ["n|k"]               = map_cmd('v:lua.enhance_jk_move("k")'):with_silent():with_expr(),

    -- Plugin QuickRun
    ["n|<localleader>r"]          = map_cr("<cmd> lua require'internal.quickrun'.run_command()"):with_noremap():with_silent(),

    -- Plugin Symbols Outline
    ["n|<localleader>o"]          = map_cu('SymbolsOutline'):with_noremap():with_silent(),

    -- Plugin vim-operator-surround
    ["n|sa"]                 = map_cmd("<Plug>(operator-surround-append)"):with_silent(),
    ["n|sd"]                 = map_cmd("<Plug>(operator-surround-delete)"):with_silent(),
    ["n|sr"]                 = map_cmd("<Plug>(operator-surround-replace)"):with_silent(),

   -- Plugin hrsh7th/vim-eft
--     ["n|;"]               = map_cmd("v:lua.enhance_ft_move(';')"):with_expr(),
--     ["x|;"]               = map_cmd("v:lua.enhance_ft_move(';')"):with_expr(),
--     ["n|f"]               = map_cmd("v:lua.enhance_ft_move('f')"):with_expr(),
--     ["x|f"]               = map_cmd("v:lua.enhance_ft_move('f')"):with_expr(),
--     ["o|f"]               = map_cmd("v:lua.enhance_ft_move('f')"):with_expr(),
--     ["n|F"]               = map_cmd("v:lua.enhance_ft_move('F')"):with_expr(),
--     ["x|F"]               = map_cmd("v:lua.enhance_ft_move('F')"):with_expr(),
--     ["o|F"]               = map_cmd("v:lua.enhance_ft_move('F')"):with_expr(),

   -- Plugin vim_niceblock
--     ["x|I"]               = map_cmd("v:lua.enhance_nice_block('I')"):with_expr(),
--     ["x|gI"]              = map_cmd("v:lua.enhance_nice_block('gI')"):with_expr(),
--     ["x|A"]               = map_cmd("v:lua.enhance_nice_block('A')"):with_expr(),

    -- Plugin nvim-dap
};

bind.nvim_load_mapping(plug_map)
