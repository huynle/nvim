local dap, dapui = require('dap'), require('dapui')
-- dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
-- dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
-- dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end

require("dapui").setup({
  icons = {
    expanded = "▾",
    collapsed = "▸",
    circular = "↺"
  },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
  },

  sidebar = {
    open_on_start = true,
    -- You can change the order of elements in the sidebar
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      {
        id = "scopes",
        size = 0.25, -- Can be float or integer > 1
      },
      { id = "breakpoints", size = 0.25 },
      { id = "stacks", size = 0.25 },
      { id = "watches", size = 00.25 },
    },
    size = 40,
    position = "left", -- Can be "left" or "right"
  },
  tray = {
    open_on_start = true,
    elements = { "repl" },
    size = 10,
    position = "bottom", -- Can be "bottom" or "top"
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },




})


vim.cmd([[
nnoremap <silent> <localleader>do <cmd>lua require'dapui'.toggle()<CR>
nnoremap <silent> <M-k> <cmd>lua require'dapui'.eval(<expression>)<CR>
vnoremap <M-k> <Cmd>lua require("dapui").eval()<CR>
" nnoremap <silent> <localleader>df <cmd>require("dapui").float_element(<element ID>)<CR>
]])
