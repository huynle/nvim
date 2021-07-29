local cb = require'diffview.config'.diffview_callback

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
			['q']         = '<cmd>DiffviewClose<CR>',

    },
    file_panel = {
			['q']         = '<cmd>DiffviewClose<CR>',
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

vim.cmd[[command! DiffviewFile execute("DiffviewOpen -- " . expand("%")) | DiffviewToggleFiles]]

-- util.nnoremap("<localleader>dd", ":DiffviewOpen master -- " .. vim.fn.expand("%") .. "<CR>")
-- util.nnoremap("<localleader>dm", ":DiffviewOpen master -- " .. vim.fn.expand("%") .. "<CR>")
-- util.nnoremap("<localleader>dr", ":DiffviewOpen HEAD~1 -- " .. vim.fn.expand("%") .. "<CR>")


-- util.nnoremap("<leader>dd", ":DiffviewOpen ") -- add branch info here
-- util.nnoremap("<leader>do", ":DiffviewOpen<CR>")
-- util.nnoremap("<leader>dm", ":DiffviewOpen master<CR>")
-- util.nnoremap("<leader>dr", ":DiffviewOpen HEAD~1<CR>")
-- util.nnoremap("<leader>dc", ":DiffviewClose<CR>")
