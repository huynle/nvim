if not pcall(require, "telescope") then
  return
end

local sorters = require "telescope.sorters"

TelescopeMapArgs = TelescopeMapArgs or {}

local map_tele = function(mode, key, f, options, buffer)
  local map_key = vim.api.nvim_replace_termcodes(key .. f, true, true, true)

  TelescopeMapArgs[map_key] = options or {}

  -- local mode = "n"
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
map_tele("n", "<Leader>en", "edit_neovim")
map_tele("n", "<leader>ed", "edit_dotfiles")
-- 
-- Search
-- TODO: I would like to completely remove _mock from my search results here when I'm in SG/SG
-- map_tele("n", "<space>gw", "grep_string", {
--   short_path = true,
--   word_match = "-w",
--   only_sort_text = true,
--   layout_strategy = "vertical",
--   sorter = sorters.get_fzy_sorter(),
-- })

-- map_tele("n", "<leader>f/", "grep_last_search", {
--   layout_strategy = "vertical",
-- })

-- Files
-- map_tele("n", "<space>ft", "git_files")
map_tele("n", "<LocalLeader>gp", "grep_prompt")
map_tele("n", "<LocalLeader>gq", "grep_quickfix")
map_tele("n", "<LocalLeader>g", "live_grep")
map_tele("v", "<LocalLeader>g", "find_word")
map_tele("n", "<LocalLeader>f", "find_files")
-- map_tele("n", "<space>fo", "oldfiles")
-- map_tele("n", "<space>fd", "fd")
-- map_tele("n", "<space>fv", "find_nvim_source")
-- map_tele("n", "<space>fe", "file_browser")
map_tele("n", "<LocalLeader>ff", "search_only_certain_files")
map_tele("n", "<LocalLeader>gg", "grep_in_path")

-- map_tele("n", "<LocalLeader>.", "symbol?")

map_tele("n", "<LocalLeader>hh",'help_tags')
map_tele("n", "<LocalLeader>hm",'keymaps')
map_tele("n", "<LocalLeader>hc",'commands')
map_tele("n", "<LocalLeader>gc",'git_commits')

map_tele("n", "<Leader>fl", 'loclist')
map_tele("n", "<Leader>g", 'current_buffer_fuzzy_find')
map_tele("n", "<Leader>fi", "tbs_infrastructure_search")
map_tele("n", "<Leader>gi", "tbs_infrastructure_live_grep")



-- Sourcegraph
-- map_tele("n", "<space>sf", "sourcegraph_find")
-- map_tele("n", "<space>saf", "sourcegraph_about_find")
-- map_tele("n", "<space>sag", "sourcegraph_about_grep")
-- map_tele("n", '<space>fz', 'sourcegraph_tips')

-- Git
map_tele("n", "<Leader>gs", "git_status")
map_tele("n", "<Leader>gc", "git_commits")

-- Nvim
-- map_tele("n", "<space>fb", "buffers")
-- map_tele("n", "<space>fp", "my_plugins")
-- map_tele("n", "<space>fa", "installed_plugins")
-- map_tele("n", "<space>fi", "search_all_files")
-- map_tele("n", "<space>ff", "curbuf")
-- map_tele("n", "<space>fh", "help_tags")
-- map_tele("n", "<space>vo", "vim_options")
-- 
-- Telescope Meta
map_tele("n", "<LocalLeader>b", "builtin")

return map_tele
