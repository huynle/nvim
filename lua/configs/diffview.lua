-- Lua
local cb = require'diffview.config'.diffview_callback
local util = require 'util'

require'diffview'.setup {
  diff_binaries = false,    -- Show diffs for binaries
  file_panel = {
    width = 35,
    use_icons = true        -- Requires nvim-web-devicons
  },
  key_bindings = {
    -- The `view` bindings are active in the diff buffers, only when the current
    -- tabpage is a Diffview.
    view = {
      ["]d"]     = cb("select_next_entry"),  -- Open the diff for the next file
      ["[d"]   = cb("select_prev_entry"),  -- Open the diff for the previous file
      ["<localleader>a"] = cb("focus_files"),        -- Bring focus to the files panel
      ["<localleader>e"] = cb("toggle_files"),       -- Toggle the files panel.
    },
    file_panel = {
      ["j"]             = cb("next_entry"),         -- Bring the cursor to the next file entry
      ["<down>"]        = cb("next_entry"),
      ["k"]             = cb("prev_entry"),         -- Bring the cursor to the previous file entry.
      ["<up>"]          = cb("prev_entry"),
      ["<cr>"]          = cb("select_entry"),       -- Open the diff for the selected entry.
      ["o"]             = cb("select_entry"),
      ["<2-LeftMouse>"] = cb("select_entry"),
      ["-"]             = cb("toggle_stage_entry"), -- Stage / unstage the selected entry.
      ["S"]             = cb("stage_all"),          -- Stage all entries.
      ["U"]             = cb("unstage_all"),        -- Unstage all entries.
      ["X"]             = cb("restore_entry"),      -- Restore entry to the state on the left side.
      ["R"]             = cb("refresh_files"),      -- Update stats and entries in the file list.
      ["]d"]         = cb("select_next_entry"),
      ["[d"]       = cb("select_prev_entry"),
      ["<localleader>a"]     = cb("focus_files"),
      ["<localleader>e"]     = cb("toggle_files"),
    }
  }
}



util.nnoremap("<leader>do", ":DiffviewOpen<CR>")
util.nnoremap("<leader>dmo", ":DiffviewOpen master -- " .. vim.fn.expand("%:p") .. "<CR>")
util.nnoremap("<leader>dm", ":DiffviewOpen master<CR>")
util.nnoremap("<leader>dc", ":DiffviewClose<CR>")
