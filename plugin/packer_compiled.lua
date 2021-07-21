-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/e367212/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/e367212/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/e367212/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/e367212/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/e367212/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["accelerated-jk"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/opt/accelerated-jk"
  },
  ["auto-session"] = {
    config = { "\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25configs.auto-session\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/opt/auto-session"
  },
  ["diffview.nvim"] = {
    commands = { "DiffviewOpen" },
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22rmagatti.diffview\frequire\0" },
    keys = { { "", "<localleader>ddo" } },
    loaded = false,
    needs_bufread = false,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/opt/diffview.nvim"
  },
  ["editorconfig-vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/opt/editorconfig-vim"
  },
  ["far.vim"] = {
    commands = { "Far", "Farp" },
    config = { "\27LJ\2\n/\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\arg\15far#source\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/opt/far.vim"
  },
  fzf = {
    loaded = false,
    needs_bufread = false,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/opt/fzf"
  },
  ["fzf.vim"] = {
    load_after = {
      ["nvim-bqf"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/opt/fzf.vim"
  },
  ["galaxyline.nvim"] = {
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23configs.galaxyline\frequire\0" },
    loaded = true,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/start/galaxyline.nvim"
  },
  ["git-worktree.nvim"] = {
    config = { "\27LJ\2\n∞\1\0\0\3\0\a\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\0016\0\4\0009\0\5\0'\2\6\0B\0\2\1K\0\1\0Knnoremap <localleader>wt <cmd>Telescope git_worktree git_worktrees<CR>\bcmd\bvim\17git_worktree\19load_extension\14telescope\frequire\0" },
    keys = { { "", "<localleader>wt" } },
    loaded = false,
    needs_bufread = false,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/opt/git-worktree.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21configs.gitsigns\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim"
  },
  hop = {
    config = { "\27LJ\2\n≈\1\0\0\6\0\n\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0009\0\5\0009\0\6\0'\2\a\0'\3\b\0'\4\t\0004\5\0\0B\0\5\1K\0\1\0+<cmd>lua require'hop'.hint_char2()<cr>\19<localleader>s\6n\20nvim_set_keymap\bapi\bvim\1\0\1\tkeys\28etovxqpdygfblzhckisuran\nsetup\bhop\frequire\0" },
    loaded = true,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/start/hop"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\nﬁ\5\0\0\3\0\15\0!6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0+\1\2\0=\1\4\0006\0\0\0009\0\1\0005\1\6\0=\1\5\0006\0\0\0009\0\1\0005\1\b\0=\1\a\0006\0\0\0009\0\1\0+\1\1\0=\1\t\0006\0\0\0009\0\1\0+\1\2\0=\1\n\0006\0\0\0009\0\1\0005\1\f\0=\1\v\0006\0\0\0009\0\r\0'\2\14\0B\0\2\1K\0\1\0001autocmd CursorMoved * IndentBlanklineRefresh\bcmd\1\f\0\0\nclass\rfunction\vmethod\nblock\17list_literal\rselector\b^if\v^table\17if_statement\nwhile\bfor&indent_blankline_context_patterns*indent_blankline_show_current_context4indent_blankline_show_trailing_blankline_indent\1\3\0\0\rterminal\vnofile%indent_blankline_buftype_exclude\1\22\0\0\rstartify\14dashboard\16dotooagenda\blog\rfugitive\14gitcommit\vpacker\fvimwiki\rmarkdown\tjson\btxt\nvista\thelp\ftodoist\rNvimTree\rpeekaboo\bgit\20TelescopePrompt\rundotree\24flutterToolsOutline\5&indent_blankline_filetype_exclude-indent_blankline_show_first_indent_level\b‚îÇ\26indent_blankline_char\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/opt/indent-blankline.nvim"
  },
  ["lspsaga.nvim"] = {
    commands = { "Lspsaga" },
    config = { "\27LJ\2\n/\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\20configs.lspsaga\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/opt/lspsaga.nvim"
  },
  ["lua-dev.nvim"] = {
    loaded = true,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/start/lua-dev.nvim"
  },
  ["markdown-preview.nvim"] = {
    config = { "\27LJ\2\n1\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\0\0=\1\2\0K\0\1\0\20mkdp_auto_start\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/opt/markdown-preview.nvim"
  },
  neogit = {
    commands = { "Neogit" },
    config = { "\27LJ\2\n]\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\17integrations\1\0\0\1\0\1\rdiffview\2\nsetup\vneogit\frequire\0" },
    loaded = false,
    needs_bufread = true,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/opt/neogit"
  },
  ["nvim-autopairs"] = {
    after = { "nvim-compe" },
    loaded = true,
    only_config = true
  },
  ["nvim-bqf"] = {
    after = { "fzf.vim" },
    config = { "\27LJ\2\nç\2\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\rfunc_map\1\0\t\vvsplit\asv\nsplit\asg\btab\ast\vsclear\r<space>c\fffilter\r<space>F\vfilter\r<space>f\14stogglevm\f<space>\16stoggledown\f<space>\16ptoggleitem\6p\fpreview\1\0\1\17auto_preview\2\1\0\2\23auto_resize_height\1\16auto_enable\2\nsetup\bbqf\frequire\0" },
    loaded = false,
    needs_bufread = true,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/opt/nvim-bqf"
  },
  ["nvim-compe"] = {
    after_files = { "/home/e367212/.local/share/nvim/site/pack/packer/opt/nvim-compe/after/plugin/compe.vim" },
    config = { "\27LJ\2\n-\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\18configs.compe\frequire\0" },
    load_after = {},
    loaded = false,
    needs_bufread = false,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/opt/nvim-compe"
  },
  ["nvim-dap"] = {
    after = { "nvim-dap-ui", "telescope-dap.nvim", "nvim-dap-python", "nvim-dap-virtual-text" },
    config = { "\27LJ\2\n`\0\0\3\0\5\0\n6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\0016\0\0\0'\2\4\0B\0\2\1K\0\1\0\16configs.dap\bdap\19load_extension\14telescope\frequire\0" },
    keys = { { "n", "<localleader>db" }, { "n", "<localleader>dB" } },
    loaded = false,
    needs_bufread = false,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/opt/nvim-dap"
  },
  ["nvim-dap-python"] = {
    load_after = {
      ["nvim-dap"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/opt/nvim-dap-python"
  },
  ["nvim-dap-ui"] = {
    load_after = {
      ["nvim-dap"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/opt/nvim-dap-ui"
  },
  ["nvim-dap-virtual-text"] = {
    load_after = {
      ["nvim-dap"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/opt/nvim-dap-virtual-text"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22configs.lspconfig\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig"
  },
  ["nvim-lspinstall"] = {
    loaded = true,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/start/nvim-lspinstall"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22configs.nvim-tree\frequire\0" },
    loaded = true,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    after = { "nvim-treesitter-textobjects" },
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23configs.treesitter\frequire\0" },
    load_after = {},
    loaded = false,
    needs_bufread = true,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/opt/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    config = { "\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24configs.textobjects\frequire\0" },
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-textobjects"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["onedark.nvim"] = {
    config = { "\27LJ\2\n^\0\0\3\0\a\0\n6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\4\0'\2\5\0B\0\2\0029\0\6\0B\0\1\1K\0\1\0\nsetup\fonedark\frequire\tdeep\18onedark_style\6g\bvim\0" },
    loaded = true,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/start/onedark.nvim"
  },
  ["orgmode.nvim"] = {
    config = { "\27LJ\2\nì\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\21org_agenda_files\1\0\1\27org_default_notes_file\26~/docs/org/refile.org\1\2\0\0\17~/docs/org/*\nsetup\forgmode\frequire\0" },
    loaded = false,
    needs_bufread = true,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/opt/orgmode.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["prodoc.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/opt/prodoc.nvim"
  },
  ["symbols-outline.nvim"] = {
    commands = { "SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose" },
    config = { "\27LJ\2\nç\2\0\0\4\0\a\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0024\3\0\0=\3\6\2B\0\2\1K\0\1\0\18lsp_blacklist\fkeymaps\1\0\6\nclose\n<Esc>\18goto_location\t<CR>\17code_actions\6a\18rename_symbol\6r\17hover_symbol\6p\19focus_location\6o\1\0\4\rposition\nright\17auto_preview\1\16show_guides\2\27highlight_hovered_item\2\nsetup\20symbols-outline\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/opt/symbols-outline.nvim"
  },
  ["telescope-dap.nvim"] = {
    config = { "\27LJ\2\nH\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\bdap\19load_extension\14telescope\frequire\0" },
    load_after = {
      ["nvim-dap"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/opt/telescope-dap.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim"
  },
  ["telescope-fzf-writer.nvim"] = {
    loaded = true,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/start/telescope-fzf-writer.nvim"
  },
  ["telescope.nvim"] = {
    after = { "nvim-treesitter" },
    loaded = true,
    only_config = true
  },
  ["todo-comments.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26configs.todo-comments\frequire\0" },
    loaded = true,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/start/todo-comments.nvim"
  },
  ["trouble.nvim"] = {
    commands = { "Trouble", "TroubleToggle" },
    loaded = false,
    needs_bufread = false,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/opt/trouble.nvim"
  },
  ["vim-commentary"] = {
    config = { "\27LJ\2\n|\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0]      xmap <Leader>v  <Plug>Commentary\n      nmap <Leader>v  <Plug>CommentaryLine\n      \bcmd\bvim\0" },
    loaded = true,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-cursorword"] = {
    config = { "\27LJ\2\n∆\3\0\0\3\0\n\0$6\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\0016\0\0\0009\0\1\0009\0\2\0'\2\4\0B\0\2\0016\0\0\0009\0\1\0009\0\2\0'\2\5\0B\0\2\0016\0\0\0009\0\1\0009\0\2\0'\2\6\0B\0\2\0016\0\0\0009\0\1\0009\0\2\0'\2\a\0B\0\2\0016\0\0\0009\0\1\0009\0\2\0'\2\b\0B\0\2\0016\0\0\0009\0\1\0009\0\2\0'\2\t\0B\0\2\1K\0\1\0\16augroup END/autocmd InsertLeave * let b:cursorword = 1/autocmd InsertEnter * let b:cursorword = 0Gautocmd WinEnter * if &diff || &pvw | let b:cursorword = 0 | endifQautocmd FileType NvimTree,lspsagafinder,dashboard,vista let b:cursorword = 0\rautocmd!#augroup user_plugin_cursorword\17nvim_command\bapi\bvim\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/opt/vim-cursorword"
  },
  ["vim-dadbod"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/opt/vim-dadbod"
  },
  ["vim-dadbod-ui"] = {
    commands = { "DBUIToggle", "DBUIAddConnection", "DBUI", "DBUIFindBuffer", "DBUIRenameBuffer" },
    config = { "\27LJ\2\nò\2\0\0\4\1\r\0\0316\0\0\0009\0\1\0)\1\0\0=\1\2\0006\0\0\0009\0\1\0'\1\4\0=\1\3\0006\0\0\0009\0\1\0)\1\1\0=\1\5\0006\0\0\0009\0\1\0)\1#\0=\1\6\0006\0\0\0009\0\1\0006\1\b\0009\1\t\1'\3\n\0B\1\2\2'\2\v\0&\1\2\1=\1\a\0006\0\0\0009\0\1\0-\1\0\0B\1\1\2=\1\f\0K\0\1\0\2¿\bdbs\30/.cache/vim/db_ui_queries\tHOME\vgetenv\aos\24db_ui_save_location\19db_ui_winwidth\25db_ui_use_nerd_fonts\tleft\23db_ui_win_position\20db_ui_show_help\6g\bvim\0" },
    loaded = false,
    needs_bufread = true,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/opt/vim-dadbod-ui"
  },
  ["vim-easy-align"] = {
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22configs.easyalign\frequire\0" },
    loaded = true,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/start/vim-easy-align"
  },
  ["vim-eft"] = {
    config = { "\27LJ\2\n0\0\0\2\0\3\0\0056\0\0\0009\0\1\0+\1\2\0=\1\2\0K\0\1\0\19eft_ignorecase\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/opt/vim-eft"
  },
  ["vim-fugitive"] = {
    commands = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull", "Gvdiffsplit" },
    config = { "\27LJ\2\nË\1\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0»\1        nnoremap <silent> <localleader>gb :<C-u>Git blame<CR>\n        nnoremap <localleader>gd :Gvdiffsplit!<CR>\n        nnoremap gj :diffget //2<CR>\n        nnoremap g; :diffget //3<CR>\n        \bcmd\bvim\0" },
    keys = { { "n", "<localleader>gd" }, { "n", "<localleader>gb" }, { "n", "<localleader>hp" }, { "n", "<localleader>hs" }, { "n", "<localleader>hu" }, { "n", "<localleader>hr" }, { "n", "<localleader>hR" }, { "n", "<localleader>hp" }, { "n", "<localleader>hb" } },
    loaded = false,
    needs_bufread = true,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/opt/vim-fugitive"
  },
  ["vim-localvimrc"] = {
    config = { "\27LJ\2\nã\2\0\0\3\0\v\0\0256\0\0\0009\0\1\0009\0\2\0B\0\1\0026\1\0\0009\1\3\1)\2\1\0=\2\4\0016\1\0\0009\1\3\1)\2\0\0=\2\5\0016\1\0\0009\1\3\1)\2\0\0=\2\6\0016\1\0\0009\1\3\0015\2\b\0=\2\a\0016\1\0\0009\1\3\0015\2\n\0=\2\t\1K\0\1\0\1\2\0\0\29~/.config/nvim/local.vim\20localvimrc_name\1\4\0\0\rVimEnter\fBufRead\rBufWrite\21localvimrc_event\23localvimrc_sandbox\19localvimrc_ask\22localvimrc_enable\6g\vgetcwd\afn\bvim\0" },
    loaded = true,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/start/vim-localvimrc"
  },
  ["vim-operator-surround"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/opt/vim-operator-surround"
  },
  ["vim-operator-user"] = {
    loaded = true,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/start/vim-operator-user"
  },
  ["vim-oscyank"] = {
    commands = { "OSCYank", "OSCYankReg" },
    loaded = false,
    needs_bufread = false,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/opt/vim-oscyank"
  },
  ["vim-puppet"] = {
    after_files = { "/home/e367212/.local/share/nvim/site/pack/packer/opt/vim-puppet/after/plugin/gutentags.vim" },
    loaded = false,
    needs_bufread = true,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/opt/vim-puppet"
  },
  ["vim-sonictemplate"] = {
    commands = { "Template" },
    config = { "\27LJ\2\n™\1\0\0\4\0\t\0\0146\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0006\1\5\0009\1\6\1'\3\a\0B\1\2\2'\2\b\0&\1\2\1=\1\4\0K\0\1\0\27/.config/nvim/template\tHOME\vgetenv\aos#sonictemplate_vim_template_dir\n<C-,>\30sonictemplate_postfix_key\6g\bvim\0" },
    loaded = false,
    needs_bufread = true,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/opt/vim-sonictemplate"
  },
  ["vim-tmux-navigator"] = {
    loaded = true,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/start/vim-tmux-navigator"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/start/vim-unimpaired"
  },
  ["vim-vsnip"] = {
    config = { "\27LJ\2\nm\0\0\4\0\a\0\n6\0\0\0009\0\1\0006\1\3\0009\1\4\1'\3\5\0B\1\2\2'\2\6\0&\1\2\1=\1\2\0K\0\1\0\27/.config/nvim/snippets\tHOME\vgetenv\aos\22vsnip_snippet_dir\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/opt/vim-vsnip"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14which-key\frequire\0" },
    loaded = true,
    path = "/home/e367212/.local/share/nvim/site/pack/packer/start/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
local module_lazy_loads = {
  ["^telescope%._extensions%.dap"] = "telescope-dap.nvim"
}
local lazy_load_called = {['packer.load'] = true}
local function lazy_load_module(module_name)
  local to_load = {}
  if lazy_load_called[module_name] then return nil end
  lazy_load_called[module_name] = true
  for module_pat, plugin_name in pairs(module_lazy_loads) do
    if not _G.packer_plugins[plugin_name].loaded and string.match(module_name, module_pat) then
      to_load[#to_load + 1] = plugin_name
    end
  end

  if #to_load > 0 then
    require('packer.load')(to_load, {module = module_name}, _G.packer_plugins)
    local loaded_mod = package.loaded[module_name]
    if loaded_mod then
      return function(modname) return loaded_mod end
    end
  end
end

if not vim.g.packer_custom_loader_enabled then
  table.insert(package.loaders, 1, lazy_load_module)
  vim.g.packer_custom_loader_enabled = true
end

-- Config for: vim-commentary
time([[Config for vim-commentary]], true)
try_loadstring("\27LJ\2\n|\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0]      xmap <Leader>v  <Plug>Commentary\n      nmap <Leader>v  <Plug>CommentaryLine\n      \bcmd\bvim\0", "config", "vim-commentary")
time([[Config for vim-commentary]], false)
-- Config for: hop
time([[Config for hop]], true)
try_loadstring("\27LJ\2\n≈\1\0\0\6\0\n\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0009\0\5\0009\0\6\0'\2\a\0'\3\b\0'\4\t\0004\5\0\0B\0\5\1K\0\1\0+<cmd>lua require'hop'.hint_char2()<cr>\19<localleader>s\6n\20nvim_set_keymap\bapi\bvim\1\0\1\tkeys\28etovxqpdygfblzhckisuran\nsetup\bhop\frequire\0", "config", "hop")
time([[Config for hop]], false)
-- Config for: vim-localvimrc
time([[Config for vim-localvimrc]], true)
try_loadstring("\27LJ\2\nã\2\0\0\3\0\v\0\0256\0\0\0009\0\1\0009\0\2\0B\0\1\0026\1\0\0009\1\3\1)\2\1\0=\2\4\0016\1\0\0009\1\3\1)\2\0\0=\2\5\0016\1\0\0009\1\3\1)\2\0\0=\2\6\0016\1\0\0009\1\3\0015\2\b\0=\2\a\0016\1\0\0009\1\3\0015\2\n\0=\2\t\1K\0\1\0\1\2\0\0\29~/.config/nvim/local.vim\20localvimrc_name\1\4\0\0\rVimEnter\fBufRead\rBufWrite\21localvimrc_event\23localvimrc_sandbox\19localvimrc_ask\22localvimrc_enable\6g\vgetcwd\afn\bvim\0", "config", "vim-localvimrc")
time([[Config for vim-localvimrc]], false)
-- Config for: onedark.nvim
time([[Config for onedark.nvim]], true)
try_loadstring("\27LJ\2\n^\0\0\3\0\a\0\n6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\4\0'\2\5\0B\0\2\0029\0\6\0B\0\1\1K\0\1\0\nsetup\fonedark\frequire\tdeep\18onedark_style\6g\bvim\0", "config", "onedark.nvim")
time([[Config for onedark.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\nX\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0B\0\2\1K\0\1\0\31configs.telescope.mappings\22configs.telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14which-key\frequire\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)
-- Config for: todo-comments.nvim
time([[Config for todo-comments.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26configs.todo-comments\frequire\0", "config", "todo-comments.nvim")
time([[Config for todo-comments.nvim]], false)
-- Config for: vim-easy-align
time([[Config for vim-easy-align]], true)
try_loadstring("\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22configs.easyalign\frequire\0", "config", "vim-easy-align")
time([[Config for vim-easy-align]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22configs.nvim-tree\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\2\n<\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\19nvim-autopairs\frequire\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: galaxyline.nvim
time([[Config for galaxyline.nvim]], true)
try_loadstring("\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23configs.galaxyline\frequire\0", "config", "galaxyline.nvim")
time([[Config for galaxyline.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
if vim.fn.exists(":DiffviewOpen") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file DiffviewOpen lua require("packer.load")({'diffview.nvim'}, { cmd = "DiffviewOpen", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":Gvdiffsplit") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file Gvdiffsplit lua require("packer.load")({'vim-fugitive'}, { cmd = "Gvdiffsplit", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":Gpull") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file Gpull lua require("packer.load")({'vim-fugitive'}, { cmd = "Gpull", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":Template") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file Template lua require("packer.load")({'vim-sonictemplate'}, { cmd = "Template", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":Git") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file Git lua require("packer.load")({'vim-fugitive'}, { cmd = "Git", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":SymbolsOutline") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file SymbolsOutline lua require("packer.load")({'symbols-outline.nvim'}, { cmd = "SymbolsOutline", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":SymbolsOutlineOpen") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file SymbolsOutlineOpen lua require("packer.load")({'symbols-outline.nvim'}, { cmd = "SymbolsOutlineOpen", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":SymbolsOutlineClose") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file SymbolsOutlineClose lua require("packer.load")({'symbols-outline.nvim'}, { cmd = "SymbolsOutlineClose", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":DBUIAddConnection") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file DBUIAddConnection lua require("packer.load")({'vim-dadbod-ui'}, { cmd = "DBUIAddConnection", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":DBUI") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file DBUI lua require("packer.load")({'vim-dadbod-ui'}, { cmd = "DBUI", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":DBUIFindBuffer") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file DBUIFindBuffer lua require("packer.load")({'vim-dadbod-ui'}, { cmd = "DBUIFindBuffer", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":DBUIRenameBuffer") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file DBUIRenameBuffer lua require("packer.load")({'vim-dadbod-ui'}, { cmd = "DBUIRenameBuffer", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":Gpush") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file Gpush lua require("packer.load")({'vim-fugitive'}, { cmd = "Gpush", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":Far") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file Far lua require("packer.load")({'far.vim'}, { cmd = "Far", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":TroubleToggle") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file TroubleToggle lua require("packer.load")({'trouble.nvim'}, { cmd = "TroubleToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":Gblame") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file Gblame lua require("packer.load")({'vim-fugitive'}, { cmd = "Gblame", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":Gstatus") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file Gstatus lua require("packer.load")({'vim-fugitive'}, { cmd = "Gstatus", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":Neogit") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file Neogit lua require("packer.load")({'neogit'}, { cmd = "Neogit", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":Farp") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file Farp lua require("packer.load")({'far.vim'}, { cmd = "Farp", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":OSCYank") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file OSCYank lua require("packer.load")({'vim-oscyank'}, { cmd = "OSCYank", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":OSCYankReg") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file OSCYankReg lua require("packer.load")({'vim-oscyank'}, { cmd = "OSCYankReg", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":DBUIToggle") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file DBUIToggle lua require("packer.load")({'vim-dadbod-ui'}, { cmd = "DBUIToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":Lspsaga") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file Lspsaga lua require("packer.load")({'lspsaga.nvim'}, { cmd = "Lspsaga", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":Trouble") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file Trouble lua require("packer.load")({'trouble.nvim'}, { cmd = "Trouble", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[nnoremap <silent> <localleader>hs <cmd>lua require("packer.load")({'vim-fugitive'}, { keys = "<lt>localleader>hs", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <localleader>db <cmd>lua require("packer.load")({'nvim-dap'}, { keys = "<lt>localleader>db", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <localleader>hb <cmd>lua require("packer.load")({'vim-fugitive'}, { keys = "<lt>localleader>hb", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <localleader>hp <cmd>lua require("packer.load")({'vim-fugitive'}, { keys = "<lt>localleader>hp", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <localleader>hR <cmd>lua require("packer.load")({'vim-fugitive'}, { keys = "<lt>localleader>hR", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <localleader>hr <cmd>lua require("packer.load")({'vim-fugitive'}, { keys = "<lt>localleader>hr", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <localleader>ddo <cmd>lua require("packer.load")({'diffview.nvim'}, { keys = "<lt>localleader>ddo", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <localleader>hu <cmd>lua require("packer.load")({'vim-fugitive'}, { keys = "<lt>localleader>hu", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <localleader>gd <cmd>lua require("packer.load")({'vim-fugitive'}, { keys = "<lt>localleader>gd", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <localleader>dB <cmd>lua require("packer.load")({'nvim-dap'}, { keys = "<lt>localleader>dB", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <localleader>gb <cmd>lua require("packer.load")({'vim-fugitive'}, { keys = "<lt>localleader>gb", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <localleader>wt <cmd>lua require("packer.load")({'git-worktree.nvim'}, { keys = "<lt>localleader>wt", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <localleader>hp <cmd>lua require("packer.load")({'vim-fugitive'}, { keys = "<lt>localleader>hp", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType c ++once lua require("packer.load")({'editorconfig-vim'}, { ft = "c" }, _G.packer_plugins)]]
vim.cmd [[au FileType vim ++once lua require("packer.load")({'vim-sonictemplate', 'editorconfig-vim'}, { ft = "vim" }, _G.packer_plugins)]]
vim.cmd [[au FileType puppet ++once lua require("packer.load")({'vim-puppet'}, { ft = "puppet" }, _G.packer_plugins)]]
vim.cmd [[au FileType lua ++once lua require("packer.load")({'vim-sonictemplate'}, { ft = "lua" }, _G.packer_plugins)]]
vim.cmd [[au FileType qf ++once lua require("packer.load")({'nvim-bqf'}, { ft = "qf" }, _G.packer_plugins)]]
vim.cmd [[au FileType zig ++once lua require("packer.load")({'editorconfig-vim'}, { ft = "zig" }, _G.packer_plugins)]]
vim.cmd [[au FileType cpp ++once lua require("packer.load")({'editorconfig-vim'}, { ft = "cpp" }, _G.packer_plugins)]]
vim.cmd [[au FileType go ++once lua require("packer.load")({'vim-sonictemplate', 'editorconfig-vim'}, { ft = "go" }, _G.packer_plugins)]]
vim.cmd [[au FileType typescript ++once lua require("packer.load")({'vim-sonictemplate', 'editorconfig-vim'}, { ft = "typescript" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascript ++once lua require("packer.load")({'vim-sonictemplate', 'editorconfig-vim'}, { ft = "javascript" }, _G.packer_plugins)]]
vim.cmd [[au FileType rust ++once lua require("packer.load")({'vim-sonictemplate', 'editorconfig-vim'}, { ft = "rust" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'vim-sonictemplate', 'markdown-preview.nvim'}, { ft = "markdown" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufRead * ++once lua require("packer.load")({'vim-operator-surround', 'nvim-treesitter', 'gitsigns.nvim', 'indent-blankline.nvim'}, { event = "BufRead *" }, _G.packer_plugins)]]
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'auto-session'}, { event = "VimEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufReadPost * ++once lua require("packer.load")({'fzf'}, { event = "BufReadPost *" }, _G.packer_plugins)]]
vim.cmd [[au BufReadPre * ++once lua require("packer.load")({'vim-cursorword', 'nvim-lspconfig', 'prodoc.nvim'}, { event = "BufReadPre *" }, _G.packer_plugins)]]
vim.cmd [[au BufNewFile * ++once lua require("packer.load")({'vim-cursorword', 'gitsigns.nvim'}, { event = "BufNewFile *" }, _G.packer_plugins)]]
vim.cmd [[au InsertCharPre * ++once lua require("packer.load")({'vim-vsnip'}, { event = "InsertCharPre *" }, _G.packer_plugins)]]
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'nvim-compe'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /home/e367212/.local/share/nvim/site/pack/packer/opt/vim-puppet/ftdetect/puppet.vim]], true)
vim.cmd [[source /home/e367212/.local/share/nvim/site/pack/packer/opt/vim-puppet/ftdetect/puppet.vim]]
time([[Sourcing ftdetect script at: /home/e367212/.local/share/nvim/site/pack/packer/opt/vim-puppet/ftdetect/puppet.vim]], false)
time([[Sourcing ftdetect script at: /home/e367212/.local/share/nvim/site/pack/packer/opt/vim-sonictemplate/ftdetect/stpl.vim]], true)
vim.cmd [[source /home/e367212/.local/share/nvim/site/pack/packer/opt/vim-sonictemplate/ftdetect/stpl.vim]]
time([[Sourcing ftdetect script at: /home/e367212/.local/share/nvim/site/pack/packer/opt/vim-sonictemplate/ftdetect/stpl.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
