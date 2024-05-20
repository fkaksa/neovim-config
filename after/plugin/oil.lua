-- local oil = require('oil')
local keymap = vim.keymap

keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
