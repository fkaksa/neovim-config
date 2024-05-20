vim.g.mapleader = ' '
--vim.g.maplocalleader = ' '

-- for more information on keymaps, see :h nvim_set_keymap
local keymap = vim.keymap

---------------------
-- General Keymaps -------------------

-- use <esc> to exit terminal mode
keymap.set('n', '<esc>', ':noh<esc>', { silent = true })
-- buffers
keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
keymap.set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
keymap.set("n", "<leader><tab>d", "<cmd>bd<cr>", { desc = "Close Buffer" })
keymap.set("n", "<leader><tab>D", "<cmd>%bd|e#|bd#<cr>", { desc = "Close all buffers except active one" })

-- Window navigation
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- decrypt selected string; in visual mode select the text and press <leader>64; command will yank the text and call decrypt function where iput of the function will be from unnamed registry
keymap.set({ 'n' }, '<leader>64', 'yaW:echo system("base64 -d", @")<cr>')

-- better indenting
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- copy relative file path to clipboard
keymap.set("n", "<leader>yd", ":let @*=expand('%')<CR>", { desc = "[FILE] Copy relative file path to clipboard" })
-- copy file path to clipboard
keymap.set("n", "<leader>yp", ":let @*=expand('%:p')<CR>", { desc = "[FILE] Copy file path to clipboard" })
-- copy directory path to clipboard
keymap.set("n", "<leader>yD", ":let @*=expand('%:p:h')<CR>", { desc = "[FILE] Copy directory path to clipboard" })
