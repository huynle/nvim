local util = require('util')

require('todo-comments').setup{
  signs = false,
  keywords = {
    FIX = {
      icon = " ",
      color = "error", -- can be a hex color, or a named color (see below)
      alt = { "FIXME", " BUG", "FIXIT", "FIX", "ISSUE" },
      -- signs = false, -- configure signs for some keywords individually
    },
    TODO = { icon = " ", color = "info" },
    HACK = { icon = " ", color = "warning" },
    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
    PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
    NOTE = { icon = " ", color = "hint", alt = { "INFO" , "hle"} },
  },
  -- colors = {
    --   error = { "LspDiagnosticsDefaultError", "ErrorMsg", "#DC2626" },
    --   warning = { "LspDiagnosticsDefaultWarning", "WarningMsg", "#FBBF24" },
    --   info = { "LspDiagnosticsDefaultInformation", "#2563EB" },
    --   hint = { "LspDiagnosticsDefaultHint", "#10B981" },
    --   default = { "Identifier", "#7C3AED" },
    -- },

  search = {
    command = "rg",
    args = {
      "--hidden", -- allow to search hidden files
      "--no-ignore-vcs", -- ignore stuff that is in Git and other VCS
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
    },
    -- regex that will be used to match keywords.
    -- don't replace the (KEYWORDS) placeholder
    pattern = [[\b(KEYWORDS):]], -- ripgrep regex
    -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
  },
}

util.nnoremap("<leader>tt", "<cmd>TodoTelescope<cr>")
