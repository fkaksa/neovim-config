vim.lsp.config('bashls', {
  filetypes = { 'sh', 'zsh' },
  settings = {
    bash = {
      format = {
        enable = true,
      },
    }
  }
})
