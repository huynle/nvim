local dap = require('dap')
-- NOTE: Read help page for a lot of cool info

-- Virtual text
vim.g.dap_virtual_text = true
-- request variable values for all frames (experimental)
-- vim.g.dap_virtual_text = 'all frames'


vim.fn.sign_define('DapBreakpoint', {text='🛑'})
vim.fn.sign_define('DapStopped', {text='🟢'})


vim.cmd([[
nnoremap <silent> <localleader>dc :lua require'dap'.continue()<CR>
nnoremap <silent> <localleader>dk :lua require'dap'.step_over()<CR>
nnoremap <silent> <localleader>d; :lua require'dap'.step_into()<CR>
nnoremap <silent> <localleader>dj :lua require'dap'.step_out()<CR>
nnoremap <silent> <localleader>ds :lua require'dap'.close()<CR>
" moving up and down the call stack?
nnoremap <silent> <M-k> :lua require'dap'.up()<CR>
nnoremap <silent> <M-j> :lua require'dap'.down()<CR>
nnoremap <silent> <localleader>db :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <localleader>dB :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <localleader>dl :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <localleader>dr :lua require'dap'.repl.open()<CR>

nnoremap <silent> <localleader>dff :Telescope dap frames<CR>
nnoremap <silent> <localleader>dfb :Telescope dap list_breakpoints<CR>
nnoremap <silent> <localleader>dfc :Telescope dap comands<CR>
nnoremap <silent> <localleader>dfd :Telescope dap configurations<CR>
nnoremap <silent> <localleader>dfv :Telescope dap variables<CR>

]])

-- Hover mapping
vim.cmd[[nnoremap <localleader>dh <cmd>lua require('dap.ui.widgets').hover()<CR>]]

-- Disabled, use nvim-dap widgets instead
-- require('rmagatti.dap.dap-ui')


-- NOTE: Custom configuration for adapters are here https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
-- ======
-- RUST, C and CPP
dap.adapters.cppdbg = {
    type = 'executable',
    command = vim.env.DAPINSTALLDIR..'ccppr_vsc/extension/debugAdapters/bin/OpenDebugAD7',
}

dap.configurations.cpp = {
  {
    name = "generic_1stage",
    type = "cppdbg",
    request = "launch",
    program = "${workspaceFolder}/cmake_build/gcc/Debug/bin/sim.exe",
    args = {
      "-MCseed","333333","generic_1stage.cmd"
    },
    stopAtEntry = true,
    cwd = "${workspaceFolder}/sandbox",
    environment = {},
    externalConsole = false,
    MIMode = "gdb",
    setupCommands = {
      {
        description = "Enable pretty-printing for gdb",
        text = "-enable-pretty-printing",
        ignoreFailures = true
      }
    }
  },
  {
    name = "mohifisim",
    type = "cppdbg",
    request = "launch",
    program = "${workspaceFolder}/cmake_build/gcc/Debug/bin/sim.exe",
    args = {
      "mohifisim.cmd"
    },
    stopAtEntry = true,
    cwd = "${workspaceFolder}/sandbox",
    environment = {},
    externalConsole = false,
    MIMode = "gdb",
    setupCommands = {
      {
        description = "Enable pretty-printing for gdb",
        text = "-enable-pretty-printing",
        ignoreFailures = true
      }
    }
  },
  {
    name = "gtest",
    type = "cppdbg",
    request = "launch",
    program = "${workspaceFolder}/cmake_build/gcc/Debug/bin/gtest.exe",
    args = {"--gtest_filter=*", --  uncomment line and replace "Test" with appropriate keyword to debug specific unit test(s)            
    "${workspaceFolder}/src/sim/test/data"},
    stopAtEntry = false,
    cwd = "${workspaceFolder}/sandbox",
    environment = {},
    externalConsole = false,
    MIMode = "gdb",
    setupCommands = {
    {
      description = "Enable pretty-printing for gdb",
      text = "-enable-pretty-printing",
      ignoreFailures = true
    }
    }
  }
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- ===
-- Golang
dap.adapters.go = function(callback, config)
    local handle, pid_or_err, port = nil, nil, 12346

    handle, pid_or_err = vim.loop.spawn("dlv", {
        args = {"dap", "-l", "127.0.0.1:" .. port},
        detached = true,
        cwd = vim.loop.cwd()
    }, vim.schedule_wrap(function(code)
        handle:close()
        print("Delve has exited with: " .. code)
    end))

    if not handle then error("FAILED:", pid_or_err) end

    vim.defer_fn(function()
        callback {type = "server", host = "127.0.0.1", port = port}
    end, 100)
end

dap.configurations.go = {
    {
        type = "go",
        name = "Debug",
        request = "launch",
        showLog = true,
        program = "${file}",
        -- console = "externalTerminal",
        dlvToolPath = vim.fn.exepath "dlv"
    }, {
        name = "Test Current File",
        type = "go",
        request = "launch",
        showLog = true,
        mode = "test",
        program = ".",
        dlvToolPath = vim.fn.exepath "dlv"
    }
}

-- ===
-- lua
local dap = require "dap"

dap.configurations.lua = {
    {
        type = "nlua",
        request = "attach",
        name = "Attach to running Neovim instance",
        host = function() return "127.0.0.1" end,
        port = function()
            local val = 54231
            return val
        end
    }
}

-- dap.configurations.lua = {
--     {
--         type = 'nlua',
--         request = 'attach',
--         name = "Attach to running Neovim instance",
--         host = function()
--             local value = vim.fn.input('Host [127.0.0.1]: ')
--             if value ~= "" then return value end
--             return '127.0.0.1'
--         end,
--         port = function()
--             local val = tonumber(vim.fn.input('Port: '))
--             assert(val, "Please provide a port number")
--             return val
--         end
--     }
-- }

dap.adapters.nlua = function(callback, config)
    callback({type = 'server', host = config.host, port = config.port})
end

-- ====
-- node stuff

dap.adapters.node2 = {
    type = 'executable',
    command = 'node',
    args = {
        vim.fn.stdpath("data") .. "/dapinstall/jsnode_dbg/" ..
            '/vscode-node-debug2/out/src/nodeDebug.js'
    }
}

dap.configurations.javascript = {
    {
        type = 'node2',
        request = 'launch',
        program = '${workspaceFolder}/${file}',
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = 'inspector',
        console = 'integratedTerminal'
    }
}

dap.configurations.typescript = {
  {
    type = 'node2',
    request = 'launch',
    program = '${workspaceFolder}/${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
}

-- ===========================



-- Custom behaviour
local M = {}

M.attach_typescript = function()
  dap.run({
    type='node2',
    request='attach',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    skipFiles = {'<node_internals>/**/*.ts'}
  })
end

M.debug_mocha = function(cmd)
  local test_cmd = './node_modules/ts-mocha/bin/ts-mocha'
  local args = cmd and {test_cmd, '--inspect-brk', '--no-parallel', (cmd:gsub('yarn test ', ''))} or {test_cmd, '--inspect-brk'}
  print(vim.inspect(table.concat(args, ' ')))

  dap.run({
    type='node2',
    request='launch',
    cwd = vim.fn.getcwd(),
    runtimeArgs = args,
    sourceMaps = true,
    protocol = 'inspector',
    skipFiles = {'<node_internals>/**/*.js'},
    console = 'integratedTerminal',
    port = 9229
  })
end

M.debug = function(runner, cmd)
  if runner:find('javascript#mocha') then M.debug_mocha(cmd) end
  if runner:find('javascript#jest') then M.debug_jest(cmd) end
end

-- TODO: setup jest debugging
M.debug_jest = function(_)
  print("==== TODO: Debug Jest")
end

return M
