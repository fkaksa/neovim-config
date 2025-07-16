-- load keymaps and settings
require('core')
-- Install package manager and plugins
require('package-manager')

-- Load LSP configuration
-- vim.lsp.enable('luals')
-- vim.lsp.enable('helm_ls')
-- vim.lsp.enable('basedpyright')
-- vim.lsp.enable('bashls')
-- vim.lsp.enable('dockerls')
-- vim.lsp.enable('gopls')
-- vim.lsp.enable('groovyls') --not working
-- vim.lsp.enable('jsonls')
-- vim.lsp.enable('kotlin_language_server')
-- vim.lsp.enable('lemminx')
-- vim.lsp.enable('marksman')
-- vim.lsp.enable('terraformls')
-- vim.lsp.enable('tflint')
-- vim.lsp.enable('yamlls')

-- Chosen theme
vim.cmd.colorscheme 'catppuccin-mocha'

-- Print location from which neovim configuration was loaded
print(os.getenv("MYVIMRC"))
