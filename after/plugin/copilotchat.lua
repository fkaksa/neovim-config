local chat = require('CopilotChat')
local keymap = vim.keymap

chat.setup({
  model = 'gpt-4o',
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
  }
})

--- Keymaps
keymap.set('n', '<leader>cco', chat.open, { desc = "[CopilotChat] Open Chat" })

keymap.set('n', "<leader>ccq",
  function()
    local input = vim.fn.input("Quick Chat: ")
    if input ~= "" then
      chat.ask(input, { selection = require("CopilotChat.select").buffer })
    end
  end,
  { desc = "[CopilotChat] Quick chat" })

keymap.set({ 'n', 'v' }, "<leader>ccp", function()
    local actions = require("CopilotChat.actions")
    require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
  end,
  { desc = "[CopilotChat] Pick prompt" })
