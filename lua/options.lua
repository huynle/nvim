-- local global = require 'global'
local global = {}
local home    = os.getenv("HOME")
local path_sep = global.is_windows and '\\' or '/'
local os_name = vim.loop.os_uname().sysname

function global:load_variables()
  self.is_mac     = os_name == 'Darwin'
  self.is_linux   = os_name == 'Linux'
  self.is_windows = os_name == 'Windows'
  self.vim_path    = vim.fn.stdpath('config')
  self.cache_dir   = home .. path_sep..'.local'..path_sep..'share'..path_sep..'nvim'..path_sep
  self.modules_dir = self.vim_path .. path_sep..'modules'
  self.path_sep = path_sep
  self.home = home
  self.data_dir = string.format('%s/site/',vim.fn.stdpath('data'))
end

global:load_variables()

-- -- # get packer installed
-- if require "first_load"() then
--   return
-- end

-- Create cache dir and subs dir
local createdir = function ()
  local data_dir = {
    global.cache_dir..'backup',
    global.cache_dir..'sessions',
    global.cache_dir..'swap',
    global.cache_dir..'tags',
    global.cache_dir..'undo'
  }
  -- There only check once that If cache_dir exists
  -- Then I don't want to check subs dir exists
  if vim.fn.isdirectory(global.cache_dir) == 0 then
    os.execute("mkdir -p " .. global.cache_dir)
    for _,v in pairs(data_dir) do
      if vim.fn.isdirectory(v) == 0 then
        os.execute("mkdir -p " .. v)
      end
    end
  end
end

createdir()

vim.g.maplocalleader = ";"
vim.g.mapleader = " "
vim.api.nvim_set_keymap('n',' ','',{noremap = true})
vim.api.nvim_set_keymap('x',' ','',{noremap = true})

-- " When the --vimgrep flag is given to ripgrep, then the default value for the --color flag changes to 'never'.
vim.go.grepprg = "rg --no-heading --vimgrep --smart-case --follow"
vim.go.grepformat = "%f:%l:%c:%m"

vim.opt.termguicolors  = true;
vim.opt.mouse          = "nv";
vim.opt.errorbells     = true;
vim.opt.visualbell     = true;
vim.opt.hidden         = true;
vim.opt.fileformats    = "unix,mac,dos";
vim.opt.magic          = true;
vim.opt.virtualedit    = "block";
vim.opt.encoding       = "utf-8";
vim.opt.viewoptions    = "folds,cursor,curdir,slash,unix";
vim.opt.sessionoptions = "curdir,help,tabpages,winsize";
vim.opt.clipboard      = "unnamedplus";
vim.opt.wildignorecase = true;
vim.opt.wildignore     = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**";
vim.opt.backup         = false;
vim.opt.writebackup    = false;
vim.opt.swapfile       = false;
vim.opt.directory      = global.cache_dir .. "swag/";
vim.opt.undodir        = global.cache_dir .. "undo/";
vim.opt.backupdir      = global.cache_dir .. "backup/";
vim.opt.viewdir        = global.cache_dir .. "view/";
vim.opt.spellfile      = global.cache_dir .. "spell/en.uft-8.add";
vim.opt.history        = 2000;
vim.opt.shada          = "!,'300,<50,@100,s10,h";
vim.opt.backupskip     = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim";
vim.opt.smarttab       = true;
vim.opt.shiftround     = true;
vim.opt.timeout        = true;
vim.opt.ttimeout       = true;
vim.opt.updatetime     = 100;
vim.opt.redrawtime     = 1500;
vim.opt.ignorecase     = true;
vim.opt.smartcase      = true;
vim.opt.infercase      = true;
vim.opt.incsearch      = true;
vim.opt.wrapscan       = true;
vim.opt.complete       = ".,w,b,k";
vim.opt.inccommand     = "nosplit";
vim.opt.grepformat     = "%f:%l:%c:%m";
vim.opt.grepprg        = 'rg --hidden --vimgrep --smart-case --';
vim.opt.breakat        = [[\ \	;:,!?]];
vim.opt.startofline    = false;
vim.opt.whichwrap      = "h,l,<,>,[,],~";
vim.opt.splitbelow     = true;
vim.opt.splitright     = true;
vim.opt.switchbuf      = "useopen";
vim.opt.backspace      = "indent,eol,start";
vim.opt.diffopt        = "filler,iwhite,internal,algorithm:patience";
vim.opt.completeopt    = "menuone,noselect";
vim.opt.jumpoptions    = "stack";
vim.opt.showmode       = false;
vim.opt.shortmess      = "aoOTIcF";
vim.opt.scrolloff      = 2;
vim.opt.sidescrolloff  = 5;
vim.opt.foldlevelstart = 99;
vim.opt.ruler          = false;
vim.opt.list           = true;
vim.opt.showtabline    = 2;
vim.opt.winwidth       = 30;
vim.opt.winminwidth    = 10;
vim.opt.pumheight      = 15;
vim.opt.helpheight     = 12;
vim.opt.previewheight  = 12;
vim.opt.showcmd        = false;
vim.opt.cmdheight      = 2;
vim.opt.cmdwinheight   = 5;
vim.opt.equalalways    = false;
vim.opt.laststatus     = 2;
vim.opt.display        = "lastline";
vim.opt.showbreak      = "↳  ";
vim.opt.listchars      = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←";
vim.opt.pumblend       = 10;
vim.opt.winblend       = 10;


if global.is_mac then
  vim.g.clipboard = {
    name = "macOS-clipboard",
    copy = {
      ["+"] = "pbcopy",
      ["*"] = "pbcopy",
    },
    paste = {
      ["+"] = "pbpaste",
      ["*"] = "pbpaste",
    },
    cache_enabled = 0
  }
  vim.g.python_host_prog = '/usr/bin/python'
  vim.g.python3_host_prog = '/usr/local/bin/python3'
end

vim.g.loaded_gzip              = 1
vim.g.loaded_tar               = 1
vim.g.loaded_tarPlugin         = 1
vim.g.loaded_zip               = 1
vim.g.loaded_zipPlugin         = 1
vim.g.loaded_getscript         = 1
vim.g.loaded_getscriptPlugin   = 1
vim.g.loaded_vimball           = 1
vim.g.loaded_vimballPlugin     = 1
vim.g.loaded_matchit           = 1
vim.g.loaded_matchparen        = 1
vim.g.loaded_2html_plugin      = 1
vim.g.loaded_logiPat           = 1
vim.g.loaded_rrhelper          = 1
vim.g.loaded_netrw             = 1
vim.g.loaded_netrwPlugin       = 1
vim.g.loaded_netrwSettings     = 1
vim.g.loaded_netrwFileHandlers = 1


local function bind_option(options)
  for k, v in pairs(options) do
    if v == true or v == false then
      vim.cmd('set ' .. k)
    else
      vim.cmd('set ' .. k .. '=' .. v)
    end
  end
end

local bw_local  = {
  undofile       = true;
  synmaxcol      = 2500;
  formatoptions  = "1jcroql";
  textwidth      = 80;
  expandtab      = true;
  autoindent     = true;
  tabstop        = 2;
  shiftwidth     = 2;
  softtabstop    = -1;
  breakindentopt = "shift:2,min:20";
  nowrap           = true;
  linebreak      = true;
  number         = true;
  relativenumber = true;
--     colorcolumn    = "80";
  foldenable     = true;
  signcolumn     = "yes";
  conceallevel   = 2;
  concealcursor  = "niv";
}

bind_option(bw_local)


