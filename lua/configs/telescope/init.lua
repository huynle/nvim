if not pcall(require, "telescope") then
  return
end


local should_reload = true
local reloader = function()
  if should_reload then
    RELOAD "plenary"
    RELOAD "popup"
    RELOAD "telescope"
  end
end

reloader()


local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local action_mt = require "telescope.actions.mt"
local sorters = require "telescope.sorters"
local themes = require "telescope.themes"
local transform_mod = require('telescope.actions.mt').transform_mod


-- Custom actions

local myactions = {}

function myactions.send_to_qflist(prompt_bufnr)
	actions.send_to_qflist(prompt_bufnr)
	require('user').qflist.open()
end

function myactions.smart_send_to_qflist(prompt_bufnr)
	actions.smart_send_to_qflist(prompt_bufnr)
	require('user').qflist.open()
end

-- Transform to Telescope proper actions.
myactions = transform_mod(myactions)




local set_prompt_to_entry_value = function(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  if not entry or not type(entry) == "table" then
    return
  end

  action_state.get_current_picker(prompt_bufnr):reset_prompt(entry.ordinal)
end


require'telescope'.setup {
  defaults = {
--     file_sorter = require('telescope.sorters').get_fzy_sorter,

    prompt_prefix = ' ❯ ',
    selection_caret = '▷ ',

		selection_strategy = 'closest',
    sorting_strategy = 'ascending',

    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

		winblend = 0,
		color_devicons = true,
		set_env = { COLORTERM = 'truecolor' },


		layout_strategy = 'horizontal',
		layout_config = {
			width = 0.8,
			height = 0.8,
			center = {
				preview_cutoff = 40
			},
			horizontal = {
				preview_cutoff = 120,
				prompt_position = 'top'
			},
			vertical = {
				preview_cutoff = 40
			},
		},


		file_ignore_patterns = {},

		vimgrep_arguments = {
			'rg',
			'--no-heading',
			'--with-filename',
			'--line-number',
			'--column',
			'--smart-case',
		},

    mappings = {
      i = {
        ["<Tab>"] = actions.move_selection_next,
        ["<C-Tab>"] = actions.move_selection_previous,
				["jk"] = { "<cmd>stopinsert<CR>", type = "command" },
        ["<C-q>"] = actions.send_to_qflist, 
        ["<C-y>"] = set_prompt_to_entry_value,


        -- insert_value
        -- insert_symbol
        -- run_builtin
        -- add_selected_to_qflist
        -- send_selected_to_qflist
        -- add_to_qflist
        -- send_to_qflist
        -- smart_send_to_qflist
        -- smart_add_to_qflist
        -- complete_tag
        -- open_qflist
      },
      n = {
        ["q"] = actions.close,
        ["<C-q>"] = actions.send_to_qflist,
        ["<Space>"] = actions.toggle_selection,
        ["Q"] = actions.send_to_qflist + actions.open_qflist,
        ["a"] = actions.add_to_qflist,
				["w"] = myactions.smart_send_to_qflist,
				["e"] = myactions.send_to_qflist,

        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        ["sv"] = actions.select_horizontal,
        ["sg"] = actions.select_vertical,
        ["st"] = actions.select_tab,

        ["!"] = actions.edit_command_line,
        ["?"] = actions.edit_search_line,
      },
    },


  },
  extensions = {
    fzy_native = {
      override_generic_sorter = true,
      override_file_sorter = true,
    },
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    fzf_writer = {
      minimum_grep_characters = 2,
      minimum_files_characters = 2,

      -- Disabled by default.
      -- Will probably slow down some aspects of the sorter, but can make color highlights.
      -- I will work on this more later.
      use_highlighter = false,
    }
  }
}

require('telescope').load_extension('fzf')
-- require('telescope').load_extension('fzf_writer')
-- require('telescope').load_extension('fzy_native')

-----##### COPIED FROM TJ ####
--https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/lua/tj/telescope/init.lua

local M = {}

function M.edit_neovim()
  local opts_with_preview, opts_without_preview

  opts_with_preview = {
    prompt_title = "~ configs ~",
    shorten_path = false,
    cwd = "~/.config/nvim",

    layout_strategy = "flex",
    layout_config = {
      width = 0.9,
      height = 0.8,

      horizontal = {
        width = { padding = 0.15 },
      },
      vertical = {
        preview_height = 0.75,
      },
    },

    attach_mappings = function(_, map)
      map("i", "<M-c>", function(prompt_bufnr)
        actions.close(prompt_bufnr)
        vim.schedule(function()
          require("telescope.builtin").find_files(opts_without_preview)
        end)
      end)

      return true
    end,
  }


  opts_without_preview = vim.deepcopy(opts_with_preview)
  opts_without_preview.previewer = false

  require("telescope.builtin").find_files(opts_with_preview)
end


function M.edit_dotfiles()
  require("telescope.builtin").find_files {
    shorten_path = false,
    cwd = "~/.dotfiles",
    find_command = {
      'rg',
      '--smart-case',
      '--ignore-vcs',
      '--glob',
      '!.git',
      '--files',
    },
    prompt = "~ dotfiles ~",
    hidden = true,

    layout_strategy = "horizontal",
    layout_config = {
      preview_width = 0.55,
    },
  }
end


function M.builtin()
  require("telescope.builtin").builtin()
end


function M.git_commits()
  require("telescope.builtin").git_commits {
    winblend = 5,
  }
end

function M.search_only_certain_files()
  require("telescope.builtin").find_files {
    find_command = {
      "rg",
      "--files",
      "--type",
      vim.fn.input "Type: ",
    },
  }
end

function M.live_grep()
  require('telescope.builtin').grep_string{
  }
  -- require("telescope").extensions.fzf_writer.staged_grep {
--     shorten_path = false,
--     previewer = true,
    -- fzf_separator = "|",
  -- }
end


function M.find_word()
  require('telescope.builtin').grep_string{
    search = vim.fn.expand("<cword>")
  }
end

function M.grep_prompt()
  -- grep for things prompt, then fuzzy find the file
  require("telescope.builtin").grep_string {
--     shorten_path = true,
    search = vim.fn.input "Grep String > ",
  }
end

function M.help_tags()
  require("telescope.builtin").help_tags {}
end

function M.grep_in_path()
  -- grep for things prompt, then fuzzy find the file
  require("telescope.builtin").grep_string {
    prompt_title  = 'Fuzzy Grep',
    --     shorten_path = true,
    search = vim.fn.input "Grep String > ",
    search_dirs = {vim.fn.input "Path > ",},
    }
end

function M.grep_last_search(opts)
  opts = opts or {}

  -- \<getreg\>\C
  -- -> Subs out the search things
  local register = vim.fn.getreg("/"):gsub("\\<", ""):gsub("\\>", ""):gsub("\\C", "")
--   opts.shorten_path = true
  opts.word_match = "-w"
  opts.search = register

  require("telescope.builtin").grep_string(opts)
end

-- 
-- function M.grep_quickfix(opts)
 -- NOT WORKING, trying to mimic telelscope builtin funbction for quickfix
--   local locations = vim.fn.getqflist()
-- 
--   if vim.tbl_isempty(locations) then
--     return
--   end
-- 
--   opts = {
--     prompt_title  = 'Quickfix',
--     finder    = finders.new_table {
--       results     = locations,
--       entry_maker = opts.entry_maker or make_entry.gen_from_quickfix(opts),
--     },
--     previewer = conf.qflist_previewer(opts),
--     sorter = conf.generic_sorter(opts),
--   })
-- 
--   require("telescope.builtin").grep_string(opts_with_preview)
-- 
-- end

function M.find_files()
  local opts = {
--     previewer = false,
--     layout_strategy = "vertical",
    --     cwd = require("nvim_lsp.util").root_pattern ".git"(vim.fn.expand "%:p"),
    theme = "dropdown",
    previewer = false,
    layout_config = { width = 0.5, height = 0.7 },
    find_command = {
      'rg',
      '--smart-case',
      '--hidden',
      '--no-ignore-vcs',
      '--glob',
      '!.git',
      '--files',
    }

  } -- define here if you want to define something

  local ok = pcall(require'telescope.builtin'.git_files, opts)
  if not ok then require'telescope.builtin'.find_files(opts) end
end


function M.project_search()
  require("telescope.builtin").find_files {
    previewer = false,
    layout_strategy = "vertical",
    cwd = require("nvim_lsp.util").root_pattern ".git"(vim.fn.expand "%:p"),
  }
end

function M.tbs_infrastructure_search()
  require("telescope.builtin").find_files {
    prompt_title = [[\ TBS Infrastructure Find File/]],
    previewer = false,
    layout_strategy = "vertical",
    search_dirs = {vim.fn.getcwd() .. "/infrastructure"},
  }
end


function M.tbs_infrastructure_live_grep()
  -- require("telescope").extensions.fzf_writer.staged_grep {
  require("telescope.builtin").grep_string {
    prompt_title = [[\ TBS Infrastructure Live Grep /]],
    search_dirs = {vim.fn.getcwd() .. "/infrastructure",},
    search = vim.fn.input "Grep String > ",
  }
end

return setmetatable({}, {
  __index = function(_, k)
    reloader()

    if M[k] then
      return M[k]
    else
      return require("telescope.builtin")[k]
    end
  end,
})
