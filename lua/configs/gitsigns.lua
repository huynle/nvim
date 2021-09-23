require('gitsigns').setup {
  signs = {
    add = {hl = 'GitGutterAdd', text = '▋'},
    change = {hl = 'GitGutterChange',text= '▋'},
    delete = {hl= 'GitGutterDelete', text = '▋'},
    topdelete = {hl ='GitGutterDeleteChange',text = '▔'},
    changedelete = {hl = 'GitGutterChange', text = '▎'},
  },
  keymaps = {
    noremap = true,
    buffer = true,

    ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
    ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},

    ['n <localleader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['v <localleader>hs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <localleader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <localleader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['v <localleader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <localleader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    ['n <localleader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n <localleader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',

    -- Text objects
    ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
    ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
  },
  watch_index = {
    interval = 1000
  },
  numhl = false,
  linehl = false,
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
  },
  current_line_blame_formatter_opts = {
    relative_time = false
  },
  attach_to_untracked = true,
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  use_decoration_api = true,
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
}
