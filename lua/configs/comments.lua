local util = require("util")

require("kommentary.config").configure_language("default", { prefer_single_line_comments = true })

vim.g.kommentary_create_default_mappings = false

util.nmap("<leader>v", "<Plug>kommentary_line_default")
util.vmap("<leader>v", "<Plug>kommentary_visual_default")
