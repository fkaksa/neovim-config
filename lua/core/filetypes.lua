--[[ Additional filetypes ]]
vim.filetype.add({
  pattern = {
    -- Detects Jenkinsfile as groovy
    ['*/Jenkinsfile*'] = 'groovy',
  },
  extensions = {
    tf = '',
  },
})

vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*.tf",
  callback = function()
    vim.bo.filetype = "terraform"
  end,
})
