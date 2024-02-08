local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp.default_keymaps({buffer = bufnr})
end)

-- configure language servers
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
require('lspconfig').yamlls.setup({
  setttings = {
    yaml = {
      schemas = {
        kubernetes = {
          '*.kube.yml',
          '*.kube.yaml',
          '*kubectl-edit-*.yaml'
        }
      }
    },
    schemaDownload = {  enable = true },
    validate = true
  }
})

lsp.setup()
