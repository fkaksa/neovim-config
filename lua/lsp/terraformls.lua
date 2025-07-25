vim.lsp.config('terraformls', {
  cmd = { "terraform-ls", "serve", "-req-concurrency", "20" },
  filetypes = { "terraform", "terraform-vars" },
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
