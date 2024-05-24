local catppuccin = require('catppuccin')

catppuccin.setup({
  flavour = "auto", -- latte, frappe, macchiato, mocha
  background = {    -- :h background
    light = "latte",
    dark = "mocha",
  },
  transparent_background = false, -- disables setting the background color.
  show_end_of_buffer = false,     -- shows the '~' characters after the end of buffers
  term_colors = false,            -- sets terminal colors (e.g. `g:terminal_color_0`)
  dim_inactive = {
    enabled = false,              -- dims the background color of inactive window
    shade = "dark",
    percentage = 0.15,            -- percentage of the shade to apply to the inactive window
  },
  no_italic = false,              -- Force no italic
  no_bold = false,                -- Force no bold
  no_underline = false,           -- Force no underline
  styles = {                      -- Handles the styles of general hi groups (see `:h highlight-args`):
    comments = { "italic" },      -- Change the style of comments
    conditionals = { "italic" },
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
    -- miscs = {}, -- Uncomment to turn off hard-coded styles
  },
  color_overrides = {
    mocha = {
      base = "#000000",
      mantle = "#000000",
      crust = "#000000",
    },
  },
  -- check color pallete:
  -- https://github.com/catppuccin/catppuccin/blob/main/docs/style-guide.md
  -- https://github.com/catppuccin/nvim/blob/d97387aea8264f484bb5d5e74f2182a06c83e0d8/lua/catppuccin/palettes/mocha.lua
  -- https://github.com/catppuccin/nvim/blob/d97387aea8264f484bb5d5e74f2182a06c83e0d8/lua/catppuccin/groups/editor.lua#L24
  highlight_overrides = {
    mocha = function(mocha)
      return {
        Comment = { fg = mocha.overlay2 },
        LineNr = { fg = mocha.subtext0 },
      }
    end,
  },
  default_integrations = true,
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    treesitter = true,
    notify = false,
    mini = {
      enabled = true,
      indentscope_color = "",
    },
  },
})
