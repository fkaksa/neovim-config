vim.lsp.config('groovyls', {
  filetypes = { 'groovy', 'Jenkinsfile' },
  settings = {
    groovy = {
      format = {
        enable = true,
      },
    }
  }
})
