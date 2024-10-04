local chat = require('CopilotChat')
local keymap = vim.keymap

chat.setup({
  -- window = {
  --   layout = 'float',
  --   relative = 'cursor',
  --   width = 1,
  --   height = 0.4,
  --   row = 1
  -- },
  prompts = {
    Tests = {
      prompt =
      '/COPILOT_GENERATE Please generate tests for my code. If filetype=helm generate helm unittests for my code',
      selection = require('CopilotChat.select').buffer
    }
  }
})

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
