return {
  -- LSP Support
  { 'neovim/nvim-lspconfig' },   -- Required
  { 'williamboman/mason.nvim' }, -- Optional
  {
    'mason-org/mason-lspconfig.nvim',
    branch = 'main'
  }, -- Optional

  -- Autocompletion
  {
    'saghen/blink.cmp',
    dependencies = {
      'saghen/blink.lib',
      'rafamadriz/friendly-snippets',
    },
    build = function()
      require('blink.cmp').build():pwait()
    end,
  },
  { "folke/lazydev.nvim" }
}
