local navic = require('nvim-navic')
local keymap = vim.keymap

navic.setup {
  icons = {
    File = ' ',
    Module = ' ',
    Namespace = ' ',
    Package = ' ',
    Class = ' ',
    Method = ' ',
    Property = ' ',
    Field = ' ',
    Constructor = ' ',
    Enum = ' ',
    Interface = ' ',
    Function = ' ',
    Variable = ' ',
    Constant = ' ',
    String = ' ',
    Number = ' ',
    Boolean = ' ',
    Array = ' ',
    Object = ' ',
    Key = ' ',
    Null = ' ',
    EnumMember = ' ',
    Struct = ' ',
    Event = ' ',
    Operator = ' ',
    TypeParameter = ' '
  },
  click = true
}

-- copy breadcrumb to clipboard
keymap.set('n', '<leader>yb',
  function()
    local bufnr = vim.api.nvim_get_current_buf()
    local breadcrumb = ''
    if navic.is_available(bufnr) then
      local navic_data = navic.get_data(bufnr)
      for _, comp in ipairs(navic_data) do
        -- if comp.name contains '.' then put '' around it
        if string.find(comp.name, '%.') then
          comp.name = '\'' .. comp.name .. '\''
        end
        breadcrumb = breadcrumb .. '.' .. comp.name
      end
    end
    vim.fn.setreg('*', breadcrumb)
  end,
  { noremap = true, silent = true, desc = 'Copy breadcrumb to clipboard'}
)
