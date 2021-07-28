local api = vim.api
local lspconfig = require 'lspconfig'
local format = require('configs.lspconfig.format')

if not packer_plugins['lspsaga.nvim'].loaded then
  vim.cmd [[packadd lspsaga.nvim]]
end

local saga = require 'lspsaga'
saga.init_lsp_saga({
  code_action_icon = ''
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

function _G.reload_lsp()
  vim.lsp.stop_client(vim.lsp.get_active_clients())
  vim.cmd [[edit]]
end

function _G.open_lsp_log()
  local path = vim.lsp.get_log_path()
  vim.cmd("edit " .. path)
end

vim.cmd('command! -nargs=0 LspLog call v:lua.open_lsp_log()')
vim.cmd('command! -nargs=0 LspRestart call v:lua.reload_lsp()')

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

local enhance_attach = function(client,bufnr)
  if client.resolved_capabilities.document_formatting then
    format.lsp_before_save()
  end
  api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

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

-- lspconfig.tsserver.setup {
--   on_attach = function(client)
--     client.resolved_capabilities.document_formatting = false
--     enhance_attach(client)
--   end
-- }

lspconfig.clangd.setup {
  cmd = {
    "clangd",
    "--background-index",
    "--suggest-missing-includes",
    "--clang-tidy",
    "--header-insertion=iwyu",
  },
}

lspconfig.rust_analyzer.setup {
  capabilities = capabilities,
}

local servers = {
  'docker-langserver','bash-language-server','pyright'
}

local function has_value (tab, val)
  for _, value in ipairs(tab) do
    if value == val then
      return true
    end
  end
  return false
end

function _G.dump(...)
  local objects = vim.tbl_map(vim.inspect, {...})
  print(unpack(objects))
end


local opts = { noremap=true, silent=true }

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
	-- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	-- See https://github.com/ray-x/lsp_signature.nvim
	-- require('lsp_signature').on_attach({
	-- 	bind = true,
	-- 	hint_enable = true,
	-- 	hint_prefix = ' ',
	-- 	handler_opts = { border = 'single' },
	-- })

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
	buf_set_keymap('n', ',s', '<cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>', opts)
	buf_set_keymap('n', ',wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	buf_set_keymap('n', ',wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	buf_set_keymap('n', ',wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	-- buf_set_keymap('n', ',rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_set_keymap('n', ',rn', '<cmd>lua require("lspsaga.rename").rename()<CR>', opts)
	buf_set_keymap('n', '[e', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', ']e', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
	buf_set_keymap('n', '<localleader>f', '<cmd>lua require("lspsaga.provider").lsp_finder()<CR>', opts)
	-- buf_set_keymap('n', '<localleader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	buf_set_keymap('n', '<localleader>a', '<cmd>lua require("lspsaga.codeaction").code_action()<CR>', opts)
	buf_set_keymap('v', '<localleader>a', ':<C-u>lua require("lspsaga.codeaction").range_code_action()<CR>', opts)
	buf_set_keymap('n', '<localleader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<localleader>s', "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", opts)
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

	-- Set some keybinds conditional on server capabilities
	if client.resolved_capabilities.document_formatting then
		buf_set_keymap("n", ",f", '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
	end
	if client.resolved_capabilities.document_range_formatting then
		buf_set_keymap("v", ",f", '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
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


local function make_config()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.textDocument.completion.completionItem.resolveSupport = {
		properties = {
			'documentation',
			'detail',
			'additionalTextEdits',
		}
	}
	return {
		on_attach = on_attach,
	}
end

local function setup_servers()
  require'lspinstall'.setup()
  local lspinstalled_servers = require'lspinstall'.installed_servers()
  for _, server in pairs(lspinstalled_servers) do
    local config = make_config()
    --     if has_value(servers, server) then
    --       require'lspconfig'[server].setup{}
    if server == 'lua' then
      -- See https://github.com/folke/lua-dev.nvim
      config.settings = lua_settings
      config = require('lua-dev').setup({
        lspconfig = config,
        library = {
          vimruntime = true, -- runtime path
          types = true, -- full signature, docs and completion
          plugins = { 'plenary.nvim' },
        },
      })
    elseif server == 'solargraph' then
      config.init_options = {
        config = {
          filetypes = {
            "ruby", "puppet"
          }
          -- settings = {
          --   solargraph = {
          --     diagnostics = true
          --   }
          -- }
        }
      }
    end


    require'lspconfig'[server].setup(config)
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end
