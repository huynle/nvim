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
      ["<C-c>"] = "Close",
    }
  }
}
