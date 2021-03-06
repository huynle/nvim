local should_reload = true
local reloader = function()
  if should_reload then
    RELOAD "plenary"
    RELOAD "popup"
    RELOAD "telescope"
    RELOAD "telescope.mappings"
  end
end

reloader()

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
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
        ["<C-c>"] = actions.close,
        ["<Tab>"] = actions.move_selection_next,
        ["<C-Tab>"] = actions.move_selection_previous,
				["jk"] = { "<cmd>stopinsert<CR>", type = "command" },
				-- ["<CR>"] = { "<cmd>stopinsert<CR>", type = "command" },
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<C-y>"] = set_prompt_to_entry_value,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,

        ["<c-x>"] = actions.select_horizontal,
        ["<c-v>"] = actions.select_vertical,
        ["<c-t>"] = actions.select_tab,


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
        ["<C-c>"] = actions.close,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<Space>"] = actions.toggle_selection + actions.move_selection_next,
        ["p"] = actions.toggle_selection + actions.move_selection_next,
        ["Q"] = actions.send_to_qflist + actions.open_qflist,
        ["a"] = actions.smart_add_to_qflist,
				["e"] = myactions.send_to_qflist,

        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        ["sg"] = actions.select_horizontal,
        ["sv"] = actions.select_vertical,
        ["st"] = actions.select_tab,

        ["<c-x>"] = actions.select_horizontal,
        ["<c-v>"] = actions.select_vertical,
        ["<c-t>"] = actions.select_tab,

        ["!"] = actions.edit_command_line,
        ["?"] = actions.edit_search_line,
      },
    },


  },
  extensions = {
    -- configuration for fzy_native
    fzy_native = {
      override_generic_sorter = true,
      override_file_sorter = true,
    },
    -- configuration for fzf-native
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    -- configuration for fzf-writer
    fzf_writer = {
      minimum_grep_characters = 4,
      minimum_files_characters = 0,

      -- Disabled by default.
      -- Will probably slow down some aspects of the sorter, but can make color highlights.
      -- I will work on this more later.
      use_highlighter = false,
    }
  }
}

-- uses c port of fzf
require('telescope').load_extension('fzf')

-- uses system fzf and rg
require('telescope').load_extension('fzf_writer')

-- uses lua built version of fzf
-- require('telescope').load_extension('fzy_native')



local function mysplit (inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t={}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    table.insert(t, str)
  end
  return t
end

-----##### COPIED FROM TJ ####
--https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/lua/tj/telescope/init.lua

local M = {}

function M.edit_neovim()
  local opts_with_preview, opts_without_preview

  opts_with_preview = {
    prompt_title = "~ Nvim Configs ~",
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

function M.live_grep_wiki()
  -- require('telescope.builtin').live_grep{
  -- -- require("telescope").extensions.fzf_writer.staged_grep{
  --   prompt_title = "Live Grep wiki",
  --   search_dirs = {"~/docs/wiki"},
  -- }
  require("telescope").extensions.fzf_writer.staged_grep {
    prompt_title = "Fzf-writer - Live Grep wiki",
    fzf_separator = "|",
    -- TODO: not working yet, for specific directory. forked fzf-writer top play
    -- with
    -- search_dir = "~/docs/wiki"
  }
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


local open_dif = function()
  local selected_entry = action_state.get_selected_entry()
  local value = selected_entry['value']
  -- close Telescope window properly prior to switching windows
  vim.api.nvim_win_close(0, true)
  local cmd = 'DiffviewOpen ' .. value
  vim.cmd(cmd)
end

function M.git_commits()
  -- hle: not working yet
    require('telescope.builtin').git_commits{
      attach_mappings = function(_, map)
        map('n', '<c-o>', open_dif)
        return true
      end
  }
end

-- function M.git_commits()
  -- require("telescope.builtin").git_commits {
  --   winblend = 5,
  -- }
-- end

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

function M.my_live_grep()
  -- require('telescope.builtin').live_grep{
  --     prompt_title = "Live Grepper",
  --   }

    ----
    --require("telescope").extensions.fzf_writer.grep{
    --  prompt_title = "Live Grepper",
    --}

    -- NOTE: a good use is to just start typing with "| <fzf_here>"
    -- so it loads all the lines without running rg
    require("telescope").extensions.fzf_writer.staged_grep {
        prompt_title = "Fzf-writer - Live Grep",
        fzf_separator = "|",
        -- search = ".*|"
      }
end

function M.grep_prompt_regex_filetype_add_args()
  local addl_args = vim.fn.input "Addition Ripgrep Args > "
  local args = mysplit(addl_args, " ")
  M.grep_prompt_regex_filetype(args)
end


function M.grep_prompt_regex_filetype(add_args)
  add_args = add_args or {}

  local function isempty(s)
    return s == nil or s == ''
  end

  function TableConcat(t1,t2)
    for i=1,#t2 do
      t1[#t1+1] = t2[i]
    end
    return t1
  end


  local my_vimgrep_arguments = {
    'rg',
    '--no-heading',
    '--with-filename',
    '--line-number',
    '--column',
    '--smart-case',
  }

  my_vimgrep_arguments = TableConcat(my_vimgrep_arguments, add_args)

  -- grep for things prompt, then fuzzy find the file
  local look_in = vim.fn.input "Path > "
  local look_for_type = vim.fn.input "File type > "
  local look_for = vim.fn.input("REGEX > ")

  if isempty(look_in) then
    look_in = vim.fn.getcwd()
  end

  if isempty(look_for_type) then
    look_for_type = ""
  else
    local types = mysplit(look_for_type, " ")
    for _, v in ipairs(types) do
      table.insert(my_vimgrep_arguments, "--type")
      table.insert(my_vimgrep_arguments, v)
    end
  end


  require("telescope.builtin").grep_string {
    vimgrep_arguments = my_vimgrep_arguments,
    prompt_title = look_in .. " : Grepped for '".. look_for .."' in filetype: '" .. look_for_type .. "'",
    search = look_for,
    search_dirs = {look_in},
    use_regex = true
  }
end


function M.search_all_files()
  require("telescope.builtin").find_files {
    find_command = { "rg", "--no-ignore", "--files" },
  }
end


function M.curbuf()
  local opts = themes.get_dropdown {
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  }
  require("telescope.builtin").current_buffer_fuzzy_find(opts)
end

function M.keymaps()
  require("telescope.builtin").keymaps()
end

function M.registers()
  require("telescope.builtin").registers()
end


function M.find_word()
  -- find the word under the cursor in normal mode, then you can do your fuzzy
  -- finding after
  local search_word = vim.fn.expand "<cword>"
  require('telescope.builtin').grep_string{
    prompt_title = "Grepped for '" .. search_word .. "'"
  }
end

function M.grep_prompt()
  -- grep for things prompt, then fuzzy find the file
  require("telescope.builtin").grep_string {
    search = vim.fn.input("Grep String > "),
  }
end

function M.grep_prompt_visual()
  -- grep for things prompt, then fuzzy find the file
  local search_word = vim.fn.VisualSelection()
  require("telescope.builtin").grep_string {
    prompt_title = "Grepped for '" .. search_word .. "'",
    search = vim.fn.input("Grep String > ", search_word),
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

 -- function M.grep_quickfix(opts)
 --  -- NOT WORKING, trying to mimic telelscope builtin funbction for quickfix
 --   local locations = vim.fn.getqflist()

 --   if vim.tbl_isempty(locations) then
 --     return
 --   end

 --   opts = {
 --     prompt_title  = 'Quickfix',
 --     finder    = finders.new_table {
 --       results     = locations,
 --       entry_maker = opts.entry_maker or make_entry.gen_from_quickfix(opts),
 --     },
 --     -- previewer = conf.qflist_previewer(opts),
 --     -- sorter = conf.generic_sorter(opts),
 --   }

 --   require("telescope.builtin").grep_string(opts_with_preview)

 -- end

function M.find_files_or_git_files()
  local opts = {
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


function M.find_files()
  local opts = {
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

  require'telescope.builtin'.find_files(opts)
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
    search = vim.fn.expand "<cword>",
  }
end

function M.tbs_infrastructure_grep_string()
  -- require("telescope").extensions.fzf_writer.staged_grep {
  require("telescope.builtin").grep_string {
    prompt_title = [[\ TBS Infrastructure Live Grep /]],
    search_dirs = {vim.fn.getcwd() .. "/infrastructure",},
  }
end

function M.tbs_infrastructure_puppet_live_grep()
  -- require("telescope").extensions.fzf_writer.staged_grep {
  require("telescope.builtin").grep_string {
    prompt_title = [[\ TBS Infrastructure Puppet Live Grep /]],
    search_dirs = {vim.fn.getcwd() .. "/infrastructure/puppet",},
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
