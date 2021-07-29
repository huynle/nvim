local util = require "util"
local Terminal  = require('toggleterm.terminal').Terminal
toggleterm = require 'toggleterm'

toggleterm.setup{
  size = 20,
  hide_numbers = true,
  open_mapping = [[<M-`>]],
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 0.3, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = false,
  insert_mappings = true,
  persist_size = true,
  direction = "horizontal",

  -- size can be a number or function which is passed the current terminal
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
}

-- local lazygit = Terminal:new({ cmd = "top", count = 1 })
local lazygit = Terminal:new({
  -- cmd = "top",
  count = 2,
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },
  -- -- function to run on opening the terminal
  -- on_open = function(term)
  --   vim.cmd("startinsert!")
  --   vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  -- end,
  -- -- function to run on closing the terminal
  -- on_close = function(term)
  --   vim.cmd("Closing terminal")
  -- end,
})

function _lazygit_toggle()
  lazygit:toggle()
end


-- Hide number column for
vim.cmd [[au TermOpen * setlocal nonumber norelativenumber]]

-- Esc twice to get to normal mode
util.tnoremap('<esc><esc>', '<C-\\><C-N>')
util.tnoremap('<C-o><C-i>', '<C-\\><C-n>')

-- NOTE: can be toggled with M-` also
util.nnoremap([[<M-w>]], "<cmd>lua _lazygit_toggle()<CR>")
-- util.nnoremap([[<M-1>]], "<cmd>3ToggleTerm direction='horizontal'<CR>")
-- util.nnoremap([[<M-2>]], "<cmd>4ToggleTerm direction='horizontal'<CR>")
-- util.nnoremap([[<leader>4v]], "<cmd>4ToggleTerm direction='vertical'<CR>")
--
