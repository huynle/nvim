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

-- -- Dotfiles
-- map_tele("n", "<Leader>en", "edit_neovim")
-- map_tele("n", "<Leader>ed", "edit_dotfiles")

-- Search
-- TODO: I would like to completely remove _mock from my search results here when I'm in SG/SG
-- map_tele("n", "<space>gw", "grep_string", {
--   short_path = true,
--   word_match = "-w",
--   only_sort_text = true,
--   layout_strategy = "vertical",
--   sorter = sorters.get_fzy_sorter(),
-- })

-- map_tele("n", "<localleader>f/", "grep_last_search", {
--   layout_strategy = "vertical",
-- })

-- Files
-- map_tele("n", "<space>ft", "git_files")
-- map_tele("n", "<Leader>gp", "grep_prompt")
map_tele("v", "<Leader>gg", "grep_prompt_visual")
-- map_tele("n", "<Leader>gq", "grep_quickfix")
-- map_tele("n", "<Leader>gg", "live_grep")
-- map_tele("n", "<Leader>G", "grep_prompt_regex_filetype")
-- map_tele("n", "<Leader>GG", "grep_prompt_regex_filetype_add_args")
map_tele("v", "<Leader>G", "grep_prompt_regex_filetype")

-- map_tele("n", "**", "find_word")
-- map_tele("n", "<Leader>fd", "find_files")
-- map_tele("n", "<Leader><leader>", "find_files")
-- map_tele("n", "<Leader>ft", "search_only_certain_files")
-- map_tele("n", "<space>fo", "oldfiles")
-- map_tele("n", "<space>fv", "find_nvim_source")
-- map_tele("n", "<leader>fe", "file_browser")
-- map_tele("n", "<leader>fr", 'registers')

-- map_tele("n", "<Leader>.", "symbol?")

-- map_tele("n", "<Leader>hh",'help_tags')
-- map_tele("n", "<Leader>hk",'keymaps')
-- map_tele("n", "<Leader>:",'commands')
--
map_tele("n", "<LocalLeader>.",'lsp_document_symbols')
map_tele("n", "<localleader>fl", 'loclist')
map_tele("n", "<localleader>g", 'curbuf')
map_tele("n", "<localleader>fi", "tbs_infrastructure_search")
map_tele("n", "<localleader>gi", "tbs_infrastructure_live_grep")
map_tele("v", "<localleader>gi", "tbs_infrastructure_grep_string")
map_tele("n", "<localleader>gip", "tbs_infrastructure_live_grep")


return map_tele
