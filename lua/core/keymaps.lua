vim.g.mapleader = ' '
--vim.g.maplocalleader = ' '

-- for more information on keymaps, see :h nvim_set_keymap
local keymap = vim.keymap

--------------------- General Keymaps -------------------

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

-- copy absolute path to clipboard
keymap.set("n", "<leader>yf", ":let @*=expand('%:p')<CR>", { desc = "[FILE] Copy absolute file path to clipboard" })
-- copy relative file path to clipboard
keymap.set("n", "<leader>yF", ":let @*=expand('%')<CR>", { desc = "[FILE] Copy relative file path to clipboard" })
-- copy absolute directory path to clipboard
keymap.set("n", "<leader>yd", ":let @*=expand('%:p:h')<CR>",
  { desc = "[FILE] Copy absolute directory path to clipboard" })
-- copy relative directory path to clipboard
keymap.set("n", "<leader>yD", ":let @*=substitute(expand('%:p:h'), getcwd() .. '/', '', '')<CR>",
  { desc = "[FILE] Copy relative path from getcwd to clipboard" })

-- add current line into quickfix list
keymap.set("n", "<leader>qa", ':caddexpr expand("%") .. ":" .. line(".") ..  ":" .. getline(".")<CR>',
  { desc = "[QUICKFIX] Add current line to quickfix list" })

-- open diffview
keymap.set("n", "<leader>do", ":DiffviewOpen<CR>", { desc = "[GIT] Open Diffview in current directory" })
-- close diffview
keymap.set("n", "<leader>dc", ":DiffviewClose<CR>", { desc = "[GIT] Close Diffview" })
-- open diff file history
keymap.set("n", "<leader>dh", ":DiffviewFileHistory<CR>", { desc = "[GIT] Toggle Diffview files" })
-- open diff file history for current file
keymap.set("n", "<leader>df", ":DiffviewFileHistory %<CR>", { desc = "[GIT] Toggle Diffview files for current file" })
-- open diff file history for visualized line
keymap.set("v", "<leader>df", ":'<,'>DiffviewFileHistory<CR>",
  { desc = "[GIT] Toggle Diffview files for visualized line" })
-- toggle diffview
keymap.set("n", "<leader>dt", ":DiffviewToggleFiles<CR>", { desc = "[GIT] Toggle Diffview files" })
