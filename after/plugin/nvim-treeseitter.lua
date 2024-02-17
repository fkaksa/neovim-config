local configs = require("nvim-treesitter.configs")

configs.setup({
  ensure_installed = {
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
  },
  sync_install = false,
  highlight = { enable = true },
  indent = { enable = true },
})
