--[[ Additional filetypes ]]
vim.filetype.add({
  pattern = {
    -- Detects Jenkinsfile as groovy
    ['*/Jenkinsfile*'] = 'groovy',
  }
})
