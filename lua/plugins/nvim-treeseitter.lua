-- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file
return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = { "lua", "bash", "vim", "vimdoc", "query", "html", "go", "bash", "yaml", "json", "markdown_inline" },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },
        })
    end
}
