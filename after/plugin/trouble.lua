local trouble = require("trouble")
local keymap = vim.keymap

keymap.set("n", "<leader>xx", function() trouble.toggle() end)
keymap.set("n", "<leader>xw", function() trouble.toggle("workspace_diagnostics") end)
keymap.set("n", "<leader>xd", function() trouble.toggle("document_diagnostics") end)
keymap.set("n", "<leader>xq", function() trouble.toggle("quickfix") end)
keymap.set("n", "<leader>xl", function() trouble.toggle("loclist") end)
keymap.set("n", "gR", function() trouble.toggle("lsp_references") end)
