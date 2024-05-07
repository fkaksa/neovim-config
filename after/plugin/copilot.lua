local copilot = require('copilot')

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
