-- load keymaps and settings
require('core')
-- Install package manager and plugins
require('package-manager')

-- Chosen theme
vim.cmd.colorscheme 'gruvbox'

-- Print location from which neovim configuration was loaded
print(os.getenv("MYVIMRC"))
