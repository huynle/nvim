local util = require 'util'
local neogit = require('neogit')

neogit.setup {
  disable_commit_confirmation = true,
  integrations = {
    diffview = true
  },
  -- override/add mappings
  mappings = {
    -- modify status buffer mappings
    status = {
      -- Adds a mapping with "B" as key that does the "BranchPopup" command
      ["B"] = "BranchPopup",
      ["="] = "Toggle",
    }
  }
}


util.nnoremap("<leader>gs", ":Neogit<CR>")
util.nnoremap("<leader>gc", ":Neogit commit<CR>")
