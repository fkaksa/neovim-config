-- Disable welcome message
vim.o.shortmess = vim.o.shortmess .. "I"

-- disable compatibility to old-time vi
vim.o.compatible = false

-- show matching
vim.o.showmatch = true

-- case insensitive
vim.o.ignorecase = true

-- middle-click paste with
vim.o.mouse = 'v'

-- enable mouse click
vim.o.mouse = 'a'

-- Save undo history
vim.o.undofile = true

-- highlight search
vim.o.hlsearch = true

-- incremental search
vim.o.incsearch = true

-- stop search at the end of file
vim.o.wrapscan = false

-- number of columns occupied by a tab
vim.o.tabstop = 2

-- see multiple spaces as tabstops so <BS> does the right thing
vim.o.softtabstop = 2

-- converts tabs to white space
vim.o.expandtab = true

-- width for autoindents
vim.o.shiftwidth = 2

-- indent a new line the same amount as the line just typed
vim.o.autoindent = true

-- add line numbers
vim.wo.number = true

-- set relative numbers
vim.o.relativenumber = true

-- get bash-like tab completions
vim.o.wildmode = 'longest,list'

-- using system clipboard
vim.o.clipboard = 'unnamedplus'

-- Speed up scrolling in Vim
vim.o.ttyfast = true

-- Set characters to used when ```set list``` is on
vim.o.listchars = 'tab:»·,trail:·,extends:>,precedes:<,eol:$,space:·'

-- Keep 3 lines below and above the cursor
vim.o.scrolloff = 5
