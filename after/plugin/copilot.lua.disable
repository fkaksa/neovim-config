local copilot = require('copilot')
local keymap = vim.keymap

copilot.setup({
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 75,
    -- accept = false,
    keymap = {
      accept = '<Tab>',
      accept_word = false,
      accept_line = false,
      dismiss = '<M-c>',
    },
  },
  panel = { enabled = false },
  filetypes = {
    yaml = true,
    helm = true,
    toml = true,
    json = true,
    lua = true,
    python = true,
    markdown = true,
    kube = true,
    docker = true,
    go = true,
    javascript = true,
    typescript = true,
    typescriptreact = true,
    javascriptreact = true,
    terraform = true,
    gitcommit = true,
    yml = true,
    sh = true,
    groovy = true,
  },
})

-- enable copilot
keymap.set('n', '<leader>ce', ':Copilot enable<CR>', { desc = 'Enable copilot' })
-- disable copilot
keymap.set('n', '<leader>cd', ':Copilot disable<CR>', { desc = 'Disable copilot' })
