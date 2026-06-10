local chat = require('CopilotChat')
local keymap = vim.keymap

chat.setup({
  model = 'claude-haiku-4.5',
  auto_insert_mode = true,
  prompts = {
    Tests = {
      prompt =
      '/COPILOT_GENERATE Please generate tests for my code. If filetype=helm generate helm unittests for my code',
      selection = require('CopilotChat.select').buffer
    },
    Commit = {
      prompt =
      '/COPILOT_GENERATE Generate a commit message following the Commitizen convention. Adhere to the following requirements: (1) Keep the title under 50 characters, (2) Wrap the body at 72 characters, (3) Format as a gitcommit code block. The message must match the pattern: "^([A-Z]+-[0-9]{1,4}): ([A-Za-z]+) .{3,}(?:\n\n?.*)*$", where the prefix (before the colon) follows the pattern [A-Z]+-[0-9]{1,4}. Extract the prefix from the git branch name (git branch command) using the pattern "^.*/([A-Z]+-[0-9]{1,4}).*$". If extraction is not possible, use "NOTICKET-000" as the default prefix.',
      selection = require('CopilotChat.select').buffer
    }
  },
})

--- Keymaps
keymap.set({ 'n', 'v' }, '<leader>cco', ':CopilotChatOpen<cr>', { desc = "[CopilotChat] Open Chat" })

keymap.set({ 'n', 'v' }, "<leader>ccp", ':CopilotChatPrompts<cr>',
  { desc = "[CopilotChat] Pick prompt" })

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = 'copilot-*',
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.opt_local.conceallevel = 0
  end,
})
