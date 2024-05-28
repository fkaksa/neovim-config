local builtin = require('telescope.builtin')
local telescope = require('telescope')
local actions = require('telescope.actions')
local keymap = vim.keymap

-- function copied from https://github.com/nvim-telescope/telescope.nvim/issues/1048#issuecomment-1679797700
local select_one_or_multi = function(prompt_bufnr)
  local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
  local multi = picker:get_multi_selection()
  if not vim.tbl_isempty(multi) then
    require('telescope.actions').close(prompt_bufnr)
    for _, j in pairs(multi) do
      if j.path ~= nil then
        if j.lnum ~= nil then
          vim.cmd(string.format("%s %s:%s", "edit", j.path, j.lnum))
        else
          vim.cmd(string.format('%s %s', 'edit', j.path))
        end
      end
    end
  else
    require('telescope.actions').select_default(prompt_bufnr)
  end
end

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ['<CR>'] = select_one_or_multi,
      },
      n = {
        ['<CR>'] = select_one_or_multi,
      }
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case",       -- smart_case (default) or "ignore_case" or "respect_case"
    },
    live_grep_args = {
      auto_quoting = true, -- enable/disable auto-quoting
      -- define mappings, e.g.
      mappings = {         -- extend mappings
        i = {
          ["<c-space>"] = actions.to_fuzzy_refine,
        },
      },
      -- ... also accepts theme settings, for example:
      -- theme = "dropdown", -- use dropdown theme
      -- theme = { }, -- use own theme spec
      -- layout_config = { mirror=true }, -- mirror preview pane
    }
  },
  -- pickers = {
  --   oldfiles = {
  --     sort_lastused = true,
  --     cwd_only = true,
  --     path_display = { 'filename_first' },
  --   },
  --   find_files = {
  --     hidden = true,
  --     find_command = {
  --       'rg',
  --       '--files',
  --       '--color',
  --       'never',
  --     },
  --   },
  --   live_grep = {
  --     path_display = { 'shorten' },
  --     mappings = {
  --       i = {
  --         ['<c-f>'] = custom_pickers.actions.set_extension,
  --         ['<c-l>'] = custom_pickers.actions.set_folders,
  --       },
  --     },
  --   },
  -- },
}

-- To get telescope extensions to work with telescope, you need to call
-- load_extension, somewhere after setup function:
telescope.load_extension('fzf')
telescope.load_extension("live_grep_args")

--
-- KEYMAPS
--
-- file pickers
keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[T] Search Files' })
keymap.set('n', '<leader>sF', function() builtin.find_files({ cwd = vim.fn.expand('%:p:h') }) end,
  { desc = '[T] Search Files in current directory' })
keymap.set('n', '<leader>sG', function() builtin.live_grep({ additional_args = { '--hidden' } }) end,
  { desc = '[T] Search by Grep' })
keymap.set("n", "<leader>sg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[T] Search current word' })
keymap.set('n', '<leader>gf', builtin.git_files, { desc = '[T] Search Git Files' })

-- vim pickers
keymap.set('n', '<leader><space>', function() builtin.buffers({ sort_lastused = true }) end,
  { desc = '[T] Find existing buffers' })
keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[T] Search keymaps' })
keymap.set('n', '<leader>sc', builtin.commands, { desc = '[T] Search commands' })
keymap.set('n', '<leader>ss', builtin.spell_suggest,
  { desc = '[T] Search spelling suggestions for the current word under the cursor' })
keymap.set('n', '<leader>sq', builtin.quickfix, { desc = '[T] Search quickfix list' })
keymap.set('n', '<leader>sh', builtin.command_history, { desc = '[T] Search command history' })
keymap.set('n', '<leader>sr', builtin.resume,
  { desc = '[T] Lists the results incl. multi-selections of the previous picker' })

-- lsp pickers
keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[T] Search diagnostics' })
