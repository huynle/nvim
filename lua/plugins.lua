local packer = require('util.packer')
-- local util = require("util")

-- local has = function(x)
--   return vim.fn.has(x) == 1
-- end

local config = {

  profile = {
    enable = true,
    threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
  },
  display = {
    open_fn = function()
      return require("packer.util").float {border = "single"}
    end
  },

  git = {
    clone_timeout = 600 -- Timeout, in seconds, for git clones
  },

  -- list of plugins that should be taken from ~/projects
  -- this is NOT packer functionality!
  local_plugins = {
    -- folke = true,
    -- ["nvim-compe"] = false,
    -- ["null-ls.nvim"] = false,
    -- ["nvim-lspconfig"] = false,
    -- ["nvim-treesitter"] = true,
  },
}

local conf = require('configs.all')

local function plugins(use)
  -- packer to manage itself, packadd is done in util/packer
  use {
    "wbthomason/packer.nvim",
    opt = true
  }

  use {"nvim-lua/popup.nvim"}

  use {"nvim-lua/plenary.nvim"}

-- here is all the mapping
  use {
    'folke/which-key.nvim',
    config = function()
      require "configs.keys"
    end,
  }

  use {
    'rmagatti/auto-session',
    event = 'VimEnter',
    config = function()
      require "configs.auto-session"
    end
  }

  use {
    'neovim/nvim-lspconfig',
    requires = { 'kabouzeid/nvim-lspinstall'},
    event = 'BufReadPre',
  }

  use {
    'kabouzeid/nvim-lspinstall',
    after = 'nvim-lspconfig',
    event = 'BufReadPost',
    config = function()
      require "configs.lspconfig"
    end,
    -- opt = true,
    -- cmd = {'LspInstall'}
  }



  -- -- LSP
  -- -- from rMagatti
  -- use {
  --   'neovim/nvim-lspconfig',
  --   event = 'BufReadPre'
  -- }
  -- use {
  --   'kabouzeid/nvim-lspinstall',
  --   requires = {'neovim/nvim-lspconfig'},
  --   config = function()
  --     require('rmagatti.lsp-server-configs')
  --   end,
  --   event = 'BufReadPost',
  --   after = 'nvim-lspconfig'
  -- }

  -- use {
  --   "ray-x/lsp_signature.nvim",
  --   module = {'lsp_signature'}
  -- }



  use {
    'folke/lua-dev.nvim',
    requires = {
      {'nvim-lua/plenary.nvim', opt = true}
    }
  }

  use {
    'glepnir/lspsaga.nvim',
    cmd = 'Lspsaga',
    config = function()
      require "configs.lspsaga"
    end
  }

  use {
    'hrsh7th/nvim-compe',
    opt = true,
    event = 'InsertEnter',
    config = function()
      require "configs.compe"
    end,
    requires = {
      {
        "windwp/nvim-autopairs",
        config = function()
          require('nvim-autopairs').setup()
        end,
      },
    },
  }



  -- use {
  --   "folke/which-key.nvim",
  --   config = function()
  --     require "configs.keys"
  --   end
  -- }

  use {
    'mtth/scratch.vim',
    cmd = "Scratch",
    -- keys = "<leader>S",
    config = function()
      vim.g.scratch_persistence_file = 1
    end,
  }


  use {
    'folke/trouble.nvim',
    cmd = {'Trouble', 'TroubleToggle'},
    -- event = "BufReadPre",
    config = function()
      -- util.nnoremap("<leader>xx", "<cmd>TroubleToggle<CR>")
      -- util.nnoremap("<leader>xt", "<cmd>Trouble todo<CR>")
      require("trouble").setup({ auto_open = false })
    end
  }


  -- Diagnostics
  use {
    disable = true,
    'folke/lsp-trouble.nvim',
    config = function()
      require("trouble").setup()
      vim.cmd[[nnoremap <leader>xx <cmd>LspTrouble<CR>]]
    end,
    keys = '<leader>xx',
    cmd = {'LspTrouble'}
  }


  use {
    event = "VimEnter",
    'embear/vim-localvimrc',
    config = function()
      -- local cwd = vim.fn.getcwd()
      vim.g.localvimrc_enable = 1
      vim.g.localvimrc_ask = 0
      vim.g.localvimrc_sandbox = 0
      vim.g.localvimrc_event = { "VimEnter", "BufRead", "BufWrite"}
--       vim.g.localvimrc_name = { cwd .. "/.project/config.vim", cwd .. "/.project/local.vim" }
      vim.g.localvimrc_name = {"~/.config/nvim/local.vim"}
    end
  }


  use {
    'hrsh7th/vim-vsnip',
    event = 'InsertCharPre',
    config = conf.vim_vsnip
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},

      -- using fzf port
      {'huynle/telescope-fzf-native.nvim', run = 'make'},

      -- using fzf lua
      -- {'nvim-telescope/telescope-fzy-native.nvim'},

      -- using system FZF?
      {'huynle/telescope-fzf-writer.nvim'},
      {'nvim-telescope/telescope-dap.nvim'},
      {'folke/todo-comments.nvim'},
    },
    config = function()
      require('configs.telescope')
      require('configs.telescope.mappings')
    end
  }

  use {
    'mattn/vim-sonictemplate',
    cmd = 'Template',
    ft = {'go','typescript','lua','javascript','vim','rust','markdown'},
    config = conf.vim_sonictemplate,
  }

  use {
    'rodjek/vim-puppet',
    ft = 'puppet'
  }


  -- disabling for now, conflict with 's' window movement key
  -- tried: 's', 'w' and 'h'
  -- all hadd conflict
  -- use {
  --   'phaazon/hop.nvim',

  --   keys = { "gh" },
  --   cmd = { "HopWord", "HopChar1" },
  --   config = function()
  --     require("util").nnoremap("gh", "<cmd>HopWord<CR>")
  --     -- require("util").nmap("s", "<cmd>HopChar1<CR>")
  --     -- you can configure Hop the way you like here; see :h hop-config
  --     require("hop").setup({})
  --   end
  --   -- as = 'hop',
  --   -- config = function()
  --   --   -- you can configure Hop the way you like here; see :h hop-config
  --   --   require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
  --   --   vim.api.nvim_set_keymap('n', '<localleader>s', "<cmd>lua require'hop'.hint_char2()<cr>", {})
  --   -- end
  -- }

  use {
    disable = false,
    'ggandor/lightspeed.nvim',
    config = function ()
      require('lightspeed').setup {
        jump_to_first_match = true,
        jump_on_partial_input_safety_timeout = 400,
        highlight_unique_chars = false,
        grey_out_search_area = true,
        match_only_the_start_of_same_char_seqs = true,
        limit_ft_matches = 5,
        full_inclusive_prefix_key = '<c-x>',
      }
    end,
    module = {'lightspeed'},
    keys = {
      {'n', 's'},
      {'n', 'S'},
      {'n', 'f'},
      {'n', 'F'},
    }
  }



  --   use {
  --     'Raimondi/delimitMate',
  --     event = 'InsertEnter',
  --     config = conf.delimimate,
  --   }



  use {
    'rhysd/accelerated-jk',
    opt = true
  }

  use {
    'ojroques/vim-oscyank',
    opt = true,
    cmd = {"OSCYank", 'OSCYankReg'}


  }

  use {
    'arecarn/vim-fold-cycle',
    config = function()

      vim.cmd[[
      "disable default mappings
      let g:fold_cycle_default_mapping = 0
      nmap <Tab> <Plug>(fold-cycle-open)
      nmap <S-Tab> <Plug>(fold-cycle-close)

      " Won't close when max fold is opened
      let g:fold_cycle_toggle_max_open  = 0

      " Won't open when max fold is closed
      let g:fold_cycle_toggle_max_close = 0
      ]]
    end
  }

  -- use {
  --   keys = {"[", "]"},
  --   'tpope/vim-unimpaired',
  -- }

  use {
    'junegunn/vim-easy-align',
    cmd = {"EasyAlign"},
    config = function()
      require 'configs.easyalign'
    end,
  }

  use {
    'itchyny/vim-cursorword',
    event = {'BufReadPre','BufNewFile'},
    config = conf.vim_cursorword
  }

  -- use {
  --   'hrsh7th/vim-eft',
  --   opt = true,
  --   config = function()
  --     vim.g.eft_ignorecase = true
  --   end
  -- }


--   use {
--     'kana/vim-operator-replace',
--     keys = {{'x','p'}},
--     config = function()
--       vim.api.nvim_set_keymap("x", "p", "<Plug>(operator-replace)",{silent =true})
--     end,
--     requires = 'kana/vim-operator-user'
--   }

--   use {
--     'kana/vim-niceblock',
--     opt = true,
--   }

  use {
    'christoomey/vim-tmux-navigator'
  }

  -- use {
  --   'nvim-treesitter/nvim-treesitter',
  --   event = 'BufRead',
  --   after = 'telescope.nvim',
  --   config = function()
  --     require 'configs.treesitter'
  --   end
  -- }

  -- use {
  --   'nvim-treesitter/nvim-treesitter-textobjects',
  --   after = 'nvim-treesitter',
  --   -- config = function()
  --   --   require 'configs.textobjects'
  --   -- end
  -- }


  use{
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    after = 'telescope.nvim',
    requires = {
      --  TODO: something odd is going on here, the loading is not in correct
      --   -- { "nvim-treesitter/playground", cmd = "TSHighlightCapturesUnderCursor" },
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter"
      },
      {
        "RRethy/nvim-treesitter-textsubjects",
        after = "nvim-treesitter"
      },
    },
    config = function()
      require('configs.treesitter')
    end
  }


  use {
    'kristijanhusak/vim-dadbod-ui',
    cmd = {'DBUIToggle','DBUIAddConnection','DBUI','DBUIFindBuffer','DBUIRenameBuffer'},
    config = conf.vim_dadbod_ui,
    requires = {{'tpope/vim-dadbod',opt = true}}
  }

  use {
    'editorconfig/editorconfig-vim',
    ft = { 'go','typescript','javascript','vim','rust','zig','c','cpp', 'puppet'}
  }

  -- use {
  --   'glepnir/prodoc.nvim',
  --   event = 'BufReadPre'
  -- }


  use {
    'folke/todo-comments.nvim',
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "BufReadPost",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require('configs.todo-comments')
    end
  }

  use {
    -- TODO: Eventually move this out to its own lua config
    'tpope/vim-commentary',
    config = function()
      vim.cmd[[
      xmap <Leader>v  <Plug>Commentary
      nmap <Leader>v  <Plug>CommentaryLine
      ]]
    end
  }

  use {
    'tpope/vim-surround',
    keys = {
      {'n', 'cs'},
      {'n', 'ds'},
      {'x', 'S'},
      {'v', 'S'},
      {'n', 'ys'}
    }
  }

  -- use {
  --   "b3nj5m1n/kommentary",
  --   opt = true,
  --   keys = {
  --     {"v", "<leader>v"},
  --     {"n", "<leader>v"},
  --   },
  --   config = function()
  --     require("configs.comments")
  --   end,
  -- }

  -- Symbols
  use {
    'simrat39/symbols-outline.nvim',
    config = function()
      require('symbols-outline').setup {
        highlight_hovered_item = true,
        show_guides = true,
        auto_preview = false,
        position = 'right',
        keymaps = {
          close = "<Esc>",
          goto_location = "<CR>",
          focus_location = "o",
          hover_symbol = "p",
          rename_symbol = "r",
          code_actions = "a",
        },
        lsp_blacklist = {},
      }
    end,
    cmd = {'SymbolsOutline', 'SymbolsOutlineOpen', 'SymbolsOutlineClose'}
  }


  -- QuickFix
  -- Fzf
  use {
    'junegunn/fzf',
    run = function()
      vim.fn['fzf#install']()
    end,
    event = {'BufReadPost'}
  }
  use {
    'junegunn/fzf.vim',
    requires = 'junegunn/fzf',
    after = {'nvim-bqf'}
  }

  -- Quickfix enhancements
  use {
    'kevinhwang91/nvim-bqf',
    requires = {{'junegunn/fzf', opt = true}, {'junegunn/fzf.vim', opt = true}},
    ft = {'qf'},
    event =  {"QuickFixCmdPost"},
    cmd =  {"BqfAutoToggle"},
    config = function()
      require('bqf').setup {
        auto_enable = true,
        auto_resize_height = false,
        func_map = {
          -- tab = 'st',
          -- split = 'sg',
          -- vsplit = 'sv',
          tab = '<c-t>',
          split = '<c-x>',
          vsplit = '<c-v>',
          ptoggleitem = 'p',
          stoggledown = '<space>',
          stogglevm = '<space>',
          filter = 'f',
          ffilter = 'F',
          sclear = 'c'
        },
        preview = {
          auto_preview = true,
          should_preview_cb = function(bufnr)
            local ret = true
            local filename = vim.api.nvim_buf_get_name(bufnr)
            local fsize = vim.fn.getfsize(filename)
            -- file size greater than 10k can't be previewed automatically
            if fsize > 100 * 1024 then
              ret = false
            end
            return ret
          end
        }
      }
    end
  }


  -- Git
  -- use {
  --   'tpope/vim-fugitive',
  --   cmd = {'Git', 'Gstatus', 'Gblame', 'Gpush', 'Gpull', 'Gvdiffsplit'},
  --   config = function ()
  --     vim.cmd[[
  --       nnoremap <silent> <localleader>gb :<C-u>Git blame<CR>
  --       nnoremap <localleader>gd :Gvdiffsplit!<CR>
  --       nnoremap gj :diffget //2<CR>
  --       nnoremap g; :diffget //3<CR>
  --       ]]
  --   end,
  --   keys = {
  --     {'n', '<localleader>gd'},
  --     {'n', '<localleader>gb'},
  --     {'n', '<localleader>hp'},
  --     {'n', '<localleader>hs'},
  --     {'n', '<localleader>hu'},
  --     {'n', '<localleader>hr'},
  --     {'n', '<localleader>hR'},
  --     {'n', '<localleader>hp'},
  --     {'n', '<localleader>hb'},
  --   }
  -- }

  use {
    'TimUntersberger/neogit',
    cmd ='Neogit',
    requires = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim'
    },
    config = function()
      require 'configs.neogit'
    end
  }


  use {
    'sindrets/diffview.nvim',
    config = function()
      require('configs.diffview')
    end,
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    ft = "NeogitStatus"
  }

  use {
    'mfussenegger/nvim-dap',
    opt = true,
    requires = {
      'rcarriga/nvim-dap-ui',
      'nvim-telescope/telescope-dap.nvim',
    },
    config = function()
      require('telescope').load_extension('dap')
      require 'configs.dap'
    end,
  }


  use {
    'mfussenegger/nvim-dap-python',
    after = 'nvim-dap'
  }


  use {
    'theHamsta/nvim-dap-virtual-text',
    after = 'nvim-dap'
  }

  use {
    'nvim-telescope/telescope-dap.nvim',
    requires = {
      'nvim-telescope/telescope.nvim'
    },
    config = function()
      require('telescope').load_extension('dap')
    end,
    after = 'nvim-dap',
    module = 'telescope._extensions.dap'
  }


  -- causing a bit of a problem here
  -- use {
  -- 'rcarriga/vim-ultest',
  --   config = "require('config.ultest').post()",
  --   run = ":UpdateRemotePlugins",
  --   requires = {"vim-test/vim-test"}
  -- }

  -- use {
  --   'brooth/far.vim',
  --   cmd = {'Far','Farp'},
  --   config = function ()
  --     vim.g['far#source'] = 'rg'
  --   end
  -- }

  use {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    config = function ()
      vim.g.mkdp_auto_start = 0
    end
  }


  use {
    'kristijanhusak/orgmode.nvim',
    ft = "org",
    keys = {
      {'n', '<Leader>oa'},
      {'n', '<Leader>oc'},
    },
    opt = true,
    config = function()
      require 'configs.orgmode'
    end,
    -- config = function()
    --   require('orgmode').setup{
    --     -- -- org_agenda_files = {'~/docs/org/*', '~/my-orgs/**/*'},
    --     -- org_agenda_files = {'~/docs/org/*'},
    --     -- org_default_notes_file = '~/docs/org/refile.org',
    --   }
    -- end
  }

  use {
    'michal-h21/vim-zettel',
    config = function()
      vim.g.nv_search_paths = {'/docs/wiki'}
    end
  }

  -- use {
  --   "vhyrro/neorg",
  --   config = function()
  --     require('neorg').setup {
  --       -- Tell Neorg what modules to load
  --       load = {
  --         ["core.defaults"] = {}, -- Load all the default modules
  --         ["core.norg.concealer"] = {}, -- Allows for use of icons
  --         ["core.keybinds"] = {
  --           config = {
  --             default_keybinds = true,
  --             neorg_leader = "<leader>o",
  --           }
  --         },
  --         ["core.norg.dirman"] = {
  --           -- Manage your directories with Neorg
  --           config = {
  --             workspaces = {
  --               my_workspace = "~/docs/neorg"
  --             }
  --           }
  --         }
  --       },
  --     }
  --   end,
  --   requires = "nvim-lua/plenary.nvim"
  -- }


  -- Statusline
  use {
    "hoob3rt/lualine.nvim",
    event = "VimEnter",
    config = [[require('configs.lualine')]],
    wants = "nvim-web-devicons",
  }


  use {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufRead',
    branch = 'master',
    config = conf.indent_blankline
  }

  use {
    'kyazdani42/nvim-tree.lua',
    cmd = {'NvimTreeToggle','NvimTreeOpen', 'NvimTreeFindFile'},
    config = function()
      require 'configs.nvim-tree'
    end,
    requires = 'kyazdani42/nvim-web-devicons'
  }

  use {
    'lewis6991/gitsigns.nvim',
    event = {'BufReadPre','BufNewFile'},
    config = function()
      require 'configs.gitsigns'
    end,
    wants = "plenary.nvim",
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }

  use {
    'dbeniamine/cheat.sh-vim',
    keys = {
      {'n', '<leader>KB'},
      {'n', '<leader>KK'},
      {'n', '<leader>KP'},
    },
    cmd = {'Cheat', 'CheatPaste'}
  }

  use {
    'vimwiki/vimwiki',
    branch = 'dev',
    setup = function()
        -- let gwiki.nested_syntaxes = {'python': 'python', 'c++': 'cpp', 'typescript': 'typescript'}
      vim.cmd("let g:vimwiki_list = [{'path': '~/docs/wiki', 'syntax': 'markdown', 'ext': '.md', 'nested_syntaxes':{'python': 'python', 'c++': 'cpp', 'typescript': 'typescript'}}]")
      vim.cmd[[
        let g:vimwiki_listsyms = '✗○◐●✓'
      ]]
    end,
    keys = {
      {'n', '<leader>ww'},
      {'n', '<leader>wi'},
      {'n', '<leader>w<leader>w'},
      {'n', '<leader>ws'},
    },
    ft = {'vimwiki', 'markdown'},
  }

  use {
    'navarasu/onedark.nvim',
    config = function()
      vim.g.onedark_style = 'deep'
      vim.g.onedark_transparent_background = true-- By default it is false
      require('onedark').setup()
    end,
  }

  -- use {
  --   'Th3Whit3Wolf/one-nvim',
  --   config = function()
  --     vim.cmd('colorscheme one-nvim')
  --     vim.g.one_nvim_transparent_bg = false -- By default it is false
  --   end,
  -- }

  -- use {
  --   'monsonjeremy/onedark.nvim',
  --   config = function()
  --     require'onedark'.setup{
  --       transparent = true,
  --       sidebars = {"qf", "vista_kind", "terminal", "packer"},
  --       -- Change the "hint" color to the "orange" color, and make the "error" color bright red
  --       colors = {hint = "orange", error = "#ff0000"}
  --     }
  --   end,
  -- }


  -- Terminal
  use({
    "akinsho/nvim-toggleterm.lua",
    config = function()
      require("configs.terminal")
    end,
    keys = {
      {'n', [[<M-`>]]},
      {'i', [[<M-`>]]},
      {'n', [[<M-w>]]},
      {'i', [[<M-w>]]},
    },
    cmd = {'ToggleTerm', 'ToggleTermOpenAll', 'ToggleTermCloseAll'}
  })

  -- make terminal a little more pretty
  use({
    "norcalli/nvim-terminal.lua",
    ft = "terminal",
    config = function()
      require("terminal").setup()
    end,
  })


  use({ "tweekmonster/startuptime.vim", cmd = "StartupTime" })

  use {
    disable = true,
    'nvim-lua/lsp-status.nvim'
    -- FIXME: needs to add to lualine, dont even know if this is necessary
    -- sections = {lualine_c = {require'lsp-status'.status}}
  }


end

return packer.setup(config, plugins)
