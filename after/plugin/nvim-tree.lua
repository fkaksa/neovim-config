-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.keymap.set('n', '<leader>n', ':NvimTreeFindFileToggle<cr>', { silent = true, desc = '[TR] Toggle nvim-tree' })
