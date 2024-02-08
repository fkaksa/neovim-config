-- {his neovim configuration was created using kickstart.nvim as a starting template
-- Kickstart neovim configuration: https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
-- Commit: d8b3b774bb642a9bdb2930f2ef0dd09e29a2f00c

-- Leader keys setup
-- (Must be before plugins are loaded)
vim.g.mapleader = ' '
--vim.g.maplocalleader = ' '

-- Install package manager and plugins
require('package-manager')
-- Auto initialize plugins and configure them (part of package-manager)
require('lazy').setup('plugins')
-- Changes to default neovim options
require('options')
-- Custom keymaps
require('keymaps')

-- Chosen theme
vim.cmd.colorscheme 'gruvbox'

-- Print location from which neovim configuration was loaded
print(os.getenv("MYVIMRC"))
