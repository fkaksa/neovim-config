-- set nohl
vim.keymap.set('n', '<esc>', ':noh<esc>', { silent = true })

-- buffers
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
vim.keymap.set("n", "<leader><tab>d", "<cmd>bd<cr>", { desc = "Close Tab" })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- decrypt selected string; in visual mode select the text and press <leader>64; command will yank the text and call decrypt function where iput of the function will be from unnamed registry
vim.keymap.set({ 'v' }, '<leader>64', 'y:echo system("base64 -d", @")<cr>')

-- Explore/Open dir structure
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
