vim.lsp.config('gopls', {
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      completeUnimported = true,
      usePlaceholders = true,
      hints = {
        assignVariableTypes = true,
      }
    }
  }
})
