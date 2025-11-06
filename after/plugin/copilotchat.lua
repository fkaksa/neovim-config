local chat = require('CopilotChat')
local keymap = vim.keymap

chat.setup({
  model = 'gpt-5-mini',
  auto_insert_mode = true,
  prompts = {
    Tests = {
      prompt =
      '/COPILOT_GENERATE Please generate tests for my code. If filetype=helm generate helm unittests for my code',
      selection = require('CopilotChat.select').buffer
    },
    Commit = {
      prompt =
      '/COPILOT_GENERATE Write commit message for the change with commitizen convention. Keep the title under 50 characters and wrap message at 72 characters. Format as a gitcommit code block. Write commit message using commitizen convention. Commit message must match pattern: "^([A-Z]+-[0-9]{1,4}): ([A-Za-z]+) .{3,}(?:\n\n?.*)*$", where part until ":" sign is called prefix and after the sign postfix. Extract prefix from the branch name if it is possible. Branch name can be in form: "^.*/<prefix>$". If it is not possible to extract the prefix, put "NOTICKET-000" as a prefix.',
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
