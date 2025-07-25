vim.lsp.config('basedpyright', {
  filetypes = { 'python' },
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = 'basic',
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      }
    }
  }
})
