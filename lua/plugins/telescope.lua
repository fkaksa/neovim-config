-- https://github.com/nvim-telescope/telescope.nvim
return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'folke/trouble.nvim', -- Optional: Not sure if this is necessary here or Lazy will figure this out by himself
  },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  }
}
