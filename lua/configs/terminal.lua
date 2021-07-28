local util = require "util"
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

-- Hide number column for
vim.cmd [[au TermOpen * setlocal nonumber norelativenumber]]

-- Esc twice to get to normal mode
util.tnoremap('<esc><esc>', '<C-\\><C-N>')
util.tnoremap('<C-o><C-i>', '<C-\\><C-n>')

util.nnoremap([[<M-1>]], "<cmd>2ToggleTerm direction='horizontal'<CR>")
util.nnoremap([[<M-2>]], "<cmd>3ToggleTerm direction='horizontal'<CR>")
util.nnoremap([[<M-3>]], "<cmd>4ToggleTerm direction='horizontal'<CR>")

util.nnoremap([[<M-1>v]], "<cmd>2ToggleTerm direction='vertical'<CR>")
util.nnoremap([[<leader>3v]], "<cmd>3ToggleTerm direction='vertical'<CR>")
util.nnoremap([[<leader>4v]], "<cmd>4ToggleTerm direction='vertical'<CR>")
