return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v4.x',
  -- version = '2afa32e732d7b36e80cd5241fbdc4a38e123c4e0',
  dependencies = {
    -- LSP Support
    { 'neovim/nvim-lspconfig' },   -- Required
    { 'williamboman/mason.nvim' }, -- Optional
    {
      'williamboman/mason-lspconfig.nvim',
      branch = 'v1.x'
    },                             -- Optional

    -- Autocompletion
    { 'hrsh7th/nvim-cmp' },         -- Required
    { 'hrsh7th/cmp-nvim-lsp' },     -- Required
    -- LuaSnip
    { 'L3MON4D3/LuaSnip' },         -- Required
    { 'saadparwaiz1/cmp_luasnip' }, -- Required
    -- navbuddy
    {
      "SmiteshP/nvim-navbuddy",
      dependencies = {
        "SmiteshP/nvim-navic",
        "MunifTanjim/nui.nvim"
      },
      opts = { lsp = { auto_attach = true } }
    },
  }
}
