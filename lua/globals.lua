function _G.reload_lsp()
  vim.lsp.stop_client(vim.lsp.get_active_clients())
  vim.cmd [[edit]]
end


function _G.has_value (tab, val)
  for _, value in ipairs(tab) do
    if value == val then
      return true
    end
  end
  return false
end

function _G.open_lsp_log()
  local path = vim.lsp.get_log_path()
  vim.cmd("edit " .. path)
end

function _G.dump(...)
  if false then
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
  end
end

vim.cmd('command! -nargs=0 LspLog call v:lua.open_lsp_log()')
vim.cmd('command! -nargs=0 LspRestart call v:lua.reload_lsp()')

-- selene: allow(global_usage)
_G.profile = function(cmd, times)
  times = times or 100
  local args = {}
  if type(cmd) == "string" then
    args = { cmd }
    cmd = vim.cmd
  end
  local start = vim.loop.hrtime()
  for _ = 1, times, 1 do
    local ok = pcall(cmd, unpack(args))
    if not ok then
      error("Command failed: " .. tostring(ok) .. " " .. vim.inspect({ cmd = cmd, args = args }))
    end
  end
  print(((vim.loop.hrtime() - start) / 1000000 / times) .. "ms")
end


_G.P = function(v)
  print(vim.inspect(v))
  return v
end
