if not pcall(require, "telescope") then
  return
end

local sorters = require "telescope.sorters"

TelescopeMapArgs = TelescopeMapArgs or {}

local map_tele = function(key, f, options, buffer)
  local map_key = vim.api.nvim_replace_termcodes(key .. f, true, true, true)

  TelescopeMapArgs[map_key] = options or {}

  local mode = "n"
  local rhs = string.format("<cmd>lua R('configs.telescope')['%s'](TelescopeMapArgs['%s'])<CR>", f, map_key)

  local map_options = {
    noremap = true,
    silent = true,
  }

  if not buffer then
    vim.api.nvim_set_keymap(mode, key, rhs, map_options)
  else
    vim.api.nvim_buf_set_keymap(0, mode, key, rhs, map_options)
  end
end

-- Dotfiles
map_tele("<Leader>en", "edit_neovim")
-- map_tele("<leader>ez", "edit_zsh")
-- 
-- Search
-- TODO: I would like to completely remove _mock from my search results here when I'm in SG/SG
-- map_tele("<space>gw", "grep_string", {
--   short_path = true,
--   word_match = "-w",
--   only_sort_text = true,
--   layout_strategy = "vertical",
--   sorter = sorters.get_fzy_sorter(),
-- })

-- map_tele("<leader>f/", "grep_last_search", {
--   layout_strategy = "vertical",
-- })

-- Files
-- map_tele("<space>ft", "git_files")
map_tele("<LocalLeader>gp", "grep_prompt")
map_tele("<LocalLeader>gq", "grep_quickfix")
map_tele("<LocalLeader>g", "live_grep")
map_tele("<LocalLeader>f", "find_files")
-- map_tele("<space>fo", "oldfiles")
-- map_tele("<space>fd", "fd")
-- map_tele("<space>fv", "find_nvim_source")
-- map_tele("<space>fe", "file_browser")
map_tele("<LocalLeader>ff", "search_only_certain_files")
map_tele("<LocalLeader>gg", "grep_in_path")

map_tele("<LocalLeader>hh",'help_tags')
map_tele("<LocalLeader>hm",'keymaps')
map_tele("<LocalLeader>hc",'commands')
map_tele("<LocalLeader>gc",'git_commits')

map_tele("<Leader>fl", 'loclist')
map_tele("<Leader>g", 'current_buffer_fuzzy_find')
map_tele("<Leader>fi", "tbs_infrastructure_search")
map_tele("<Leader>gi", "tbs_infrastructure_live_grep")



-- Sourcegraph
-- map_tele("<space>sf", "sourcegraph_find")
-- map_tele("<space>saf", "sourcegraph_about_find")
-- map_tele("<space>sag", "sourcegraph_about_grep")
-- map_tele('<space>fz', 'sourcegraph_tips')

-- Git
map_tele("<Leader>gs", "git_status")
map_tele("<Leader>gc", "git_commits")

-- Nvim
-- map_tele("<space>fb", "buffers")
-- map_tele("<space>fp", "my_plugins")
-- map_tele("<space>fa", "installed_plugins")
-- map_tele("<space>fi", "search_all_files")
-- map_tele("<space>ff", "curbuf")
-- map_tele("<space>fh", "help_tags")
-- map_tele("<space>vo", "vim_options")
-- 
-- Telescope Meta
map_tele("<LocalLeader>b", "builtin")

return map_tele
