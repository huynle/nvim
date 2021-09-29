-- local lspconfig = require 'lspconfig'
local has_lsp, lspconfig = pcall(require, "lspconfig")
if not has_lsp then
  return
end

local lspinstall = require "lspinstall".setup()
local extract_config = require "lspinstall/util".extract_config

local lspkind = require "lspkind"
local nvim_status = require "lsp-status"
local status = require "configs.lspconfig.status"

lspkind.init()
status.activate()

if not packer_plugins['lspsaga.nvim'].loaded then
  vim.cmd [[packadd lspsaga.nvim]]
end

local saga = require 'lspsaga'

saga.init_lsp_saga(
  {
    code_action_icon = ''
  }
)

function defaultTable(t, d)
  local mt = {
    __index = function ()
      return d 
    end,

    __add = function (t1, t2)
        local ret = {}
        for i, v in ipairs(t1) do
            table.insert(ret, v)
        end
        for i, v in ipairs(t2) do
            table.insert(ret, v)
        end
        return ret
      end
  }

  setmetatable(t, mt)
end

local custom_init = function(client)
  client.config.flags = client.config.flags or {}
  client.config.flags.allow_incremental_sync = true
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities.textDocument.completion.completionItem.snippetSupport = true
updated_capabilities = vim.tbl_deep_extend("keep", updated_capabilities, nvim_status.capabilities)
updated_capabilities = require("cmp_nvim_lsp").update_capabilities(updated_capabilities)
updated_capabilities.textDocument.completion.completionItem.resolveSupport = {
   properties = {
     'documentation',
     'detail',
     'additionalTextEdits',
   }
 }


-- dont show diagnostic line
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Enable underline, use default values
    underline = true,
    -- Enable virtual text, override spacing to 4
    virtual_text = false,
    signs = {
      enable = true,
      priority = 20
    },
    -- Disable a feature
    update_in_insert = false,
})

-- lspconfig.gopls.setup {
--   cmd = {"gopls","--remote=auto"},
--   on_attach = enhance_attach,
--   capabilities = capabilities,
--   init_options = {
--     usePlaceholders=true,
--     completeUnimported=true,
--   }
-- }

-- lspconfig.sumneko_lua.setup {
--   cmd = {
--     global.home.."/workstation/lua-language-server/bin/macOS/lua-language-server",
--     "-E",
--     global.home.."/workstation/lua-language-server/main.lua"
--   };
--   settings = {
--     Lua = {
--       diagnostics = {
--         enable = true,
--         globals = {"vim","packer_plugins"}
--       },
--       runtime = {version = "LuaJIT"},
--       workspace = {
--         library = vim.list_extend({[vim.fn.expand("$VIMRUNTIME/lua")] = true},{}),
--       },
--     },
--   }
-- }


local servers = {
  bashls = {
    cmd = {
      string.format('%s/lspinstall/bash/./node_modules/.bin/bash-language-server',vim.fn.stdpath('data')),
      "start"
    }
  },

  python = true,
  vim = true,
  lua = true,
  yamlls = {
    cmd = {
      string.format('%s/lspinstall/yaml/./node_modules/.bin/yaml-language-server',vim.fn.stdpath('data')),
      "--stdio"
    }
  },

  cmake = (1 == vim.fn.executable "cmake-language-server"),
  clangd = {
    cmd = {
      string.format('%s/lspinstall/cpp/clangd/bin/clangd',vim.fn.stdpath('data')),
      "--background-index",
      "--suggest-missing-includes",
      "--clang-tidy",
      "--header-insertion=iwyu",
    },
    -- Required for lsp-status
    init_options = {
      clangdFileStatus = true,
    },
    handlers = nvim_status.extensions.clangd.setup(),
  },

  -- gopls = {
  --   root_dir = function(fname)
  --     local Path = require "plenary.path"

  --     local absolute_cwd = Path:new(vim.loop.cwd()):absolute()
  --     local absolute_fname = Path:new(fname):absolute()

  --     if string.find(absolute_cwd, "/cmd/", 1, true) and string.find(absolute_fname, absolute_cwd, 1, true) then
  --       return absolute_cwd
  --     end

  --     return lspconfig_util.root_pattern("go.mod", ".git")(fname)
  --   end,

  --   settings = {
  --     gopls = {
  --       codelenses = { test = true },
  --     },
  --   },

  --   flags = {
  --     debounce_text_changes = 200,
  --   },
  -- },

  tsserver = {
    cmd = {
      string.format('%s/lspinstall/typescript/node_modules/.bin/typescript-language-server',vim.fn.stdpath('data')),
      "--stdio"
    },
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
  },
}


local function has_value (tab, val)
  for _, value in ipairs(tab) do
    if value == val then
      return true
    end
  end
  return false
end



local opts = { noremap=true, silent=true }

local filetype_attach = setmetatable({
  go = function(client)
    vim.cmd [[
      augroup lsp_buf_format
        au! BufWritePre <buffer>
        autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()
      augroup END
    ]]
  end,

  rust = function()
    telescope_mapper("<space>wf", "lsp_workspace_symbols", {
      ignore_filename = true,
      query = "#",
    }, true)

    -- vim.cmd [[
    --   autocmd BufEnter,BufWritePost <buffer> :lua require('lsp_extensions.inlay_hints').request {aligned = true, prefix = " » "}
    -- ]]

    vim.cmd [[
      augroup lsp_buf_format
        au! BufWritePre <buffer>
        autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()
      augroup END
    ]]
  end,
}, {
  __index = function()
    return function() end
  end,
})

local function buf_set_keymap(...)
  vim.api.nvim_buf_set_keymap(bufnr, ...)
end


local custom_attach = function(client, bufnr)
  local filetype = vim.api.nvim_buf_get_option(0, "filetype")

  nvim_status.on_attach(client)

  -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- 	buf_set_keymap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- 	buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua require("lspsaga.hover").render_hover_doc()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- 	buf_set_keymap('n', ',s', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<localleader>s', '<cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>', opts)
  buf_set_keymap('n', ',wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', ',wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', ',wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- buf_set_keymap('n', ',rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<localleader>rn', '<cmd>lua require("lspsaga.rename").rename()<CR>', opts)
  buf_set_keymap('n', '[x', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']x', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>f', '<cmd>lua require("lspsaga.provider").lsp_finder()<CR>', opts)
  -- buf_set_keymap('n', '<localleader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<M-Space>', '<cmd>lua require("lspsaga.codeaction").code_action()<CR>', opts)
  buf_set_keymap('v', '<M-Space>', ':<C-u>lua require("lspsaga.codeaction").range_code_action()<CR>', opts)
  buf_set_keymap('n', '<localleader>x', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<leader>s', "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", opts)
  -- buf_set_keymap('n', '<localleader>q', ':lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  --


  ---- Lsp mapp work when insertenter and lsp start
  --["n|<localleader>li"]         = map_cr("LspInfo"):with_noremap():with_silent():with_nowait(),
  --["n|<localleader>ll"]         = map_cr("LspLog"):with_noremap():with_silent():with_nowait(),
  --["n|<localleader>lr"]         = map_cr("LspRestart"):with_noremap():with_silent():with_nowait(),
  --["n|<C-f>"]              = map_cmd("<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>"):with_silent():with_noremap():with_nowait(),
  --["n|<C-b>"]              = map_cmd("<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>"):with_silent():with_noremap():with_nowait(),
  --["n|]e"]                 = map_cr('Lspsaga diagnostic_jump_next'):with_noremap():with_silent(),
  --["n|[e"]                 = map_cr('Lspsaga diagnostic_jump_prev'):with_noremap():with_silent(),
  --["n|K"]                  = map_cr("Lspsaga hover_doc"):with_noremap():with_silent(),
  --["n|<localleader>a"]                 = map_cr("Lspsaga code_action"):with_noremap():with_silent(),
  --["v|<localleader>a"]                 = map_cu("Lspsaga range_code_action"):with_noremap():with_silent(),
  --["n|gd"]                 = map_cr('Lspsaga preview_definition'):with_noremap():with_silent(),
  ---- ["n|gD"]                 = map_cmd("<cmd>lua vim.lsp.buf.implementation()<CR>"):with_noremap():with_silent(),
  ---- ["n|,s"]                 = map_cr('Lspsaga signature_help'):with_noremap():with_silent(),
  ---- ["n|rn"]                 = map_cr('Lspsaga rename'):with_noremap():with_silent(),
  --["n|<localleader>f"]                 = map_cr('Lspsaga lsp_finder'):with_noremap():with_silent(),
  ---- ["n|gt"]                 = map_cmd("<cmd>lua vim.lsp.buf.type_definition()<CR>"):with_noremap():with_silent(),
  ---- ["n|<localleader>s"]          = map_cmd("<cmd>lua vim.lsp.buf.workspace_symbol()<CR>"):with_noremap():with_silent(),
  ---- ["n|<localleader>e"]          = map_cr('Lspsaga show_line_diagnostics'):with_noremap():with_silent(),
  --["n|<localleader>ct"]         = map_args("Template"),
  ----
  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"


  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("v", "<leader>=", '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
  end

  -- -- Set some keybinds conditional on server capabilities
  -- if client.resolved_capabilities.document_formatting then
  --   buf_set_keymap("n", ",f", '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  -- end
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.cmd [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
    hi! LspReferenceRead ctermbg=237 guibg=#3D3741
    hi! LspReferenceText ctermbg=237 guibg=#373B41
    hi! LspReferenceWrite ctermbg=237 guibg=#374137
    augroup lsp_document_highlight
    autocmd! * <buffer>
    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]], false)
  end

  -- Attach any filetype specific options to the client
  filetype_attach[filetype](client)
end


local lua_settings = {
  Lua = {
    runtime = { version = 'LuaJIT', path = vim.split(package.path, ';'), },
    diagnostics = {
      enable = true,
      globals = {'vim', 'use', 'describe', 'it', 'assert', 'before_each', 'after_each'},
    },
    workspace = {
      preloadFileSize = 400,
      library = {
        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
      },
    },
  }
}


-- local function make_config()
--   return {
--     on_attach = custom_attach ,
--   }
-- end

-- local function setup_servers()
--   require'lspinstall'.setup()
--   local lspinstalled_servers = require'lspinstall'.installed_servers()
--   for _, server in pairs(lspinstalled_servers) do
--     local config = make_config()
--     --     if has_value(servers, server) then
--     --       require'lspconfig'[server].setup{}
--     if server == 'lua' then
--       -- See https://github.com/folke/lua-dev.nvim
--       config.settings = lua_settings
--       config = require('lua-dev').setup({
--         lspconfig = config,
--         library = {
--           vimruntime = true, -- runtime path
--           types = true, -- full signature, docs and completion
--           plugins = { 'plenary.nvim' },
--         },
--       })
--     elseif server == 'solargraph' then
--       config.init_options = {
--         config = {
--           filetypes = {
--             "ruby", "puppet"
--           }
--           -- settings = {
--           --   solargraph = {
--           --     diagnostics = true
--           --   }
--           -- }
--         }
--       }
--     end


--     require'lspconfig'[server].setup(config)
--   end
-- end

-- setup_servers()
--
local setup_server = function(server, config)
  if not config then
    return
  end

  if type(config) ~= "table" then
    config = {}
  end

  config = vim.tbl_deep_extend("force", {
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = updated_capabilities,
    flags = {
      debounce_text_changes = 50,
    },
  }, config)

  lspconfig[server].setup(config)
end


for server, config in pairs(servers) do

  installed = pcall(extract_config, server)
  istable = type(config) == "table"
  -- dump(server)
  -- dump(installed)
  -- dump(istable)

  if not installed and not istable then
    print("Need to do LspIntall", server)
    goto continue
  elseif not installed and istable then
    -- using manual config
    print("Using manual configurations for ", server)
  elseif installed and istable then
    -- extract out the default config and override it with any custom values
    default_config = extract_config(server)
    config = vim.tbl_deep_extend("force", default_config, config)
  elseif installed and not istable then
    -- using lspinstall default configurations
    config = extract_config(server)
  end 

  -- if server == "bashls" then
  --   dump(config)
  -- end

  setup_server(server, config)

  ::continue::
end

-- -- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
-- require'lspinstall'.post_install_hook = function ()
--   run() -- reload installed servers
--   vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
-- end


-- -- not necessary unless something else would use this
-- return {
--   on_init = custom_init,
--   on_attach = custom_attach,
--   capabilities = updated_capabilities,
-- }
