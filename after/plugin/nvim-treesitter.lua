local treesitter = require("nvim-treesitter")

treesitter.setup {
  -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
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
  'markdown',
  "terraform",
  "kotlin",
}

-- TODO: do it for all filetypes
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'terraform', 'terraform-vars', 'markdown_inline', 'markdown' },
  callback = function()
    -- syntax highlighting, provided by Neovim
    vim.treesitter.start()
    -- folds, provided by Neovim
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    -- indentation, provided by nvim-treesitter
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
