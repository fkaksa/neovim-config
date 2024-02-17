return {
  'nvimdev/lspsaga.nvim',
  event = 'LspAttach',
  ft = { 'javascript', 'typescript', 'typescriptreact', 'javascriptreact', 'vue', 'svelte', 'css', 'scss', 'html', 'json', 'yaml', 'markdown', 'lua', 'json' },
  dependencies = {
    'neovim/nvim-lspconfig',           -- Required

    'nvim-treesitter/nvim-treesitter', -- optional
    'nvim-tree/nvim-web-devicons',     -- optional
  }
}
