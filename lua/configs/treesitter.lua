-- local present, ts_config = pcall(require, "nvim-treesitter.configs")
-- if not present then
--     return
-- end

vim.api.nvim_command('set foldmethod=expr')
vim.api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')


require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    'c',
    'cmake',
    'comment',
    'python',
    'cpp',
    'lua',
    'yaml',
    'toml',
    'dockerfile',
    'bash',
    'json',
    'regex',
    'go',
    'javascript',
    'typescript'
  },
  highlight = { enable = true, use_languagetree = true },
  indent = { enable = false },
  context_commentstring = { enable = true },
  autopairs = { enable = true },
  textsubjects = {
    enable = true,
    keymaps = {
      ["."] = "textsubjects-smart",
      [";"] = "textsubjects-container-outer",
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["as"] = "@statement.outer",
        ["il"] = "@loop.inner",
        ["al"] = "@loop.outer",
        ["ib"] = "@block.inner",
        ["ab"] = "@block.outer",
        -- [""] = "@call.inner",
        -- [""] = "@call.outer",
        ["icl"] = "@class.inner",
        ["acl"] = "@class.outer",
        ["acm"] = "@comment.outer",
        ["icd"] = "@conditional.inner",
        ["acd"] = "@conditional.outer",
        -- [""] = "@frame.inner",
        -- [""] = "@frame.outer",
        ["ir"] = "@parameter.inner",
        ["ar"] = "@parameter.outer",
        -- [""] = "@scopename.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
}
