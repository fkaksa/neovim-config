-- https://github.com/nvim-telescope/telescope.nvim
return {
  'nvim-telescope/telescope.nvim',
  branch = 'master',
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
  },
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    -- TODO: Consider upgrading to 1.1.0
    -- I saw that the latest version has some different picker for C-space
    version = "^1.0.0",
  },
  { 'nvim-telescope/telescope-ui-select.nvim' },
}
