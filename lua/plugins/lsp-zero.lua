return {
  -- LSP Support
  { 'neovim/nvim-lspconfig' },   -- Required
  { 'williamboman/mason.nvim' }, -- Optional
  {
    'mason-org/mason-lspconfig.nvim',
    branch = 'main'
  }, -- Optional

  -- Autocompletion
  { 'hrsh7th/nvim-cmp' },         -- Required
  { 'hrsh7th/cmp-nvim-lsp' },     -- Required
  -- LuaSnip
  { 'L3MON4D3/LuaSnip' },         -- Required
  { 'saadparwaiz1/cmp_luasnip' }, -- Required
}
