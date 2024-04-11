-- Plugin configuration
return {
  'SmiteshP/nvim-navic',
  dependencies = {
    'neovim/nvim-lspconfig',
  },
  opts = {
    highlight = true,
    lsp = {
      auto_attach = true,
      preference = nil,
    },
  },
}
