vim.g.material_style = "deep ocean"
-- vim.g.material_style = "lighter"

vim.g.sonokai_style = "atlantis"
vim.g.sonokai_enable_italic = 1
vim.g.sonokai_disable_italic_comment = 1
vim.g.sonokai_diagnostic_virtual_text = "colored"

vim.g.edge_style = "neon"
vim.g.edge_enable_italic = 1
vim.g.edge_disable_italic_comment = 0
vim.g.edge_transparent_background = 1

vim.g.one_nvim_transparent_bg = true

vim.g.embark_terminal_italics = 1

vim.g.nightflyTransparent = 0

vim.g.nvcode_termcolors = 256


vim.g.tokyonight_dev = true
vim.g.tokyonight_style = "storm"
vim.g.tokyonight_sidebars = {
  "qf",
  "vista_kind",
  "terminal",
  "packer",
  "spectre_panel",
  "NeogitStatus",
  "help",
}
vim.g.tokyonight_cterm_colors = false
vim.g.tokyonight_terminal_colors = true
vim.g.tokyonight_italic_comments = true
vim.g.tokyonight_italic_keywords = true
vim.g.tokyonight_italic_functions = false
vim.g.tokyonight_italic_variables = false
vim.g.tokyonight_transparent = true
vim.g.tokyonight_hide_inactive_statusline = true
vim.g.tokyonight_dark_sidebar = true
vim.g.tokyonight_dark_float = true
vim.g.tokyonight_colors = {}
-- vim.g.tokyonight_colors = { border = "orange" }

vim.g.onedark_style = 'deep'
vim.g.onedark_transparent_background = true-- By default it is false


-- =======
-- require("tokyonight").colorscheme()

-- vim.cmd("colorscheme one-nvim") -- Put your favorite colorscheme here
--
-- vim.cmd("colorscheme edge") -- Put your favorite colorscheme here
--
-- vim.cmd('colorscheme base16-onedark')

-- require('onedark').setup()

-- ======


require('material').setup({
	contrast = false, -- Enable contrast for sidebars, floating windows and popup menus like Nvim-Tree
	borders = false, -- Enable borders between verticaly split windows

	italics = {
		comments = false, -- Enable italic comments
		keywords = false, -- Enable italic keywords
		functions = false, -- Enable italic functions
		strings = false, -- Enable italic strings
		variables = false -- Enable italic variables
	},

	contrast_windows = { -- Specify which windows get the contrasted (darker) background
		"terminal", -- Darker terminal background
		"packer", -- Darker packer background
    "nvim-tree",
		"qf" -- Darker qf list background
	},

	text_contrast = {
		lighter = true, -- Enable higher contrast text for lighter style
		darker = true-- Enable higher contrast text for darker style
	},
  disable = {
    background = false, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
    term_colors = false, -- Prevent the theme from setting terminal colors
    eob_lines = false -- Hide the end-of-buffer lines
  }
}
)

vim.api.nvim_set_keymap('n', '<leader>ml', [[<Cmd>lua require('material.functions').change_style('lighter')<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>md', [[<Cmd>lua require('material.functions').change_style('deep ocean')<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>bg', [[<Cmd>lua require('material.functions').toggle_style()<CR>]], { noremap = true, silent = true })
vim.cmd('colorscheme material')

-- vim.o.background = "light"
vim.o.background = "dark"
