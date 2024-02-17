local comment = require('Comment')

comment.setup({
  padding = true,
  ignore = "^$",
  extra = {
    ---Add comment on the line above
    above = 'gcO',
    ---Add comment on the line below
    below = 'gco',
    ---Add comment at the end of line
    eol = 'gcA',
  },
  mappings = {
    basic = true,
    extra = true,
  },
})
