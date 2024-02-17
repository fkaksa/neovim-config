local builtin = require('telescope.builtin')
local telescope = require('telescope')
local trouble = require('trouble')
local keymap = vim.keymap

-- file pickers
keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[T] Search Files' })
keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[T] Search by Grep' })
keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[T] Search current word' })
keymap.set('n', '<leader>gf', builtin.git_files, { desc = '[T] Search Git Files' })
-- vim pickers
keymap.set('n', '<leader><space>', function() builtin.buffers({ sort_lastused = true }) end,
  { desc = '[T] Find existing buffers' })
keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[T] Search keymaps' })
keymap.set('n', '<leader>sc', builtin.commands, { desc = '[T] Search commands' })
keymap.set('n', '<leader>ss', builtin.spell_suggest,
  { desc = '[T] Search spelling suggestions for the current word under the cursor' })
-- lsp pickers
keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[T] Search diagnostics' })

telescope.setup {
  defaults = {
    mappings = {
      i = { ["<c-t>"] = trouble.open_with_trouble },
      n = { ["<c-t>"] = trouble.open_with_trouble },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                         -- false will only do exact matching
      override_generic_sorter = true,       -- override the generic sorter
      override_file_sorter = true,          -- override the file sorter
      case_mode = "smart_case",             -- smart_case (default) or "ignore_case" or "respect_case"
    }
  }
}

-- To get telescope extensions to work with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
