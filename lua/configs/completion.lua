-- vim.cmd[[let g:completion_chain_complete_list = { 'default': [{'complete_items': ['lsp', 'tags']},]}]]

vim.g.completion_chain_complete_list = {
  default = {
    completion_items = {
      'lsp', 'tags'
    }
  }
}

vim.g.test = 1
