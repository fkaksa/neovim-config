return {
  -- newer version is not working properly with v0.9.5
  -- commit = 'f34237e8a41ebc6e2716af2ebf49854d8c5289c8',
  'SmiteshP/nvim-navbuddy',
  dependencies = {
    "SmiteshP/nvim-navic",
    "MunifTanjim/nui.nvim"
  },
  opts = { lsp = { auto_attach = true } }
}
