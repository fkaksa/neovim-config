---  Language Specific Plugins
---
return {
  ---  language syntax
  ---
  {
    'ckipp01/nvim-jenkinsfile-linter',
    event = 'BufRead *.jenkinsfile,*.Jenkinsfile,Jenkinsfile,jenkinsfile,Jenkinsfile_*,jenkinsfile_*',
    ft = "groovy",
  },
  {
    'martinda/Jenkinsfile-vim-syntax',
    event = 'BufRead *.jenkinsfile,*.Jenkinsfile,Jenkinsfile,jenkinsfile,Jenkinsfile_*,jenkinsfile_*',
    ft = "groovy",
  }
}
