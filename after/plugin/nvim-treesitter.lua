local configs = require("nvim-treesitter")

configs.setup({
  install = {
    "lua",
    "bash",
    "vim",
    "vimdoc",
    "query",
    "html",
    "go",
    "bash",
    "yaml",
    "json",
    "markdown_inline",
    "terraform",
    "kotlin",
  },
  sync_install = false,
  highlight = { enable = true },
  indent = { enable = true },
})
