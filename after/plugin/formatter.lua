require('formatter').setup {
  filetype = {
    go = {
      require('formatter.filetypes.go').goimports,
    },
    kotlin = {
      require('formatter.filetypes.kotlin').ktlint,
    },
    ['*'] = {
      require('formatter.filetypes.any').remove_trailing_whitespace
    },
  }
}

vim.api.nvim_create_augroup('__formatter__', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  group = '__formatter__',
  command = ':FormatWrite',
})
