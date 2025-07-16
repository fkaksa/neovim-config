vim.lsp.config('terraformls', {
  cmd = { "terraform-ls", "serve", "-req-concurrency", "20" },
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true,
        }
      }
    }
  },
  validations = {
    enableEnhancedValidation = true,
  },
  init_options = {
    experimentalFeatures = {
      prefillRequiredFields = true,
      validateOnSave = true,
    }
  }
})
