-- Plugin configuration
return {
  "SmiteshP/nvim-navic",
  enabled = true,
  lazy = true,
  event = "LspAttach",
  dependencies = {
    "neovim/nvim-lspconfig",
  },
  opts = {
    highlight = true,
    lsp = {
      auto_attach = true,
      preference = {
        "yamlls",
        "ansiblels",
        "helm_ls",
      },
    },
  },
}
