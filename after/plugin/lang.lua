local jenkins = require('jenkinsfile_linter')
local keymap = vim.keymap

keymap.set("n", "<leader>lj", function() jenkins.validate() end, { desc = "Linter Jenkinsfile" })
