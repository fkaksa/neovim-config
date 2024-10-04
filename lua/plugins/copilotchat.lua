-- https://github.com/CopilotC-Nvim/CopilotChat.nvim/tree/canary
-- had to install tiktoken to get it to work: sudo luarocks install --lua-version 5.1 tiktoken_core
return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" },  -- for curl, log wrapper
      { 'nvim-telescope/telescope.nvim' },
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {},
    -- See Commands section for default commands if you want to lazy load on them
  },
}
