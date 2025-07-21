local treesitter = require("nvim-treesitter")

treesitter.setup {
  -- Directory to install parsers and queries to
  install_dir = vim.fn.stdpath('data') .. '/site'
}
treesitter.install {
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
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = { '*' },
  callback = function() vim.treesitter.start() end,
})
