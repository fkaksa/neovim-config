return {
  'SmiteshP/nvim-navbuddy',
  enabled = true,
  event = "LspAttach",
  dependencies = {
    "neovim/nvim-lspconfig",
    "SmiteshP/nvim-navic",
    "MunifTanjim/nui.nvim",
    "nvim-telescope/telescope.nvim",
  },
}
