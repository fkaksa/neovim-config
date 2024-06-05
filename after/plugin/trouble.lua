local trouble = require("trouble")
local keymap = vim.keymap

-- keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
-- keymap.set("n", "<leader>xw", function() trouble.toggle("workspace_diagnostics") end)
-- keymap.set("n", "<leader>xd", function() trouble.toggle("document_diagnostics") end)
-- keymap.set("n", "<leader>xq", function() trouble.toggle("quickfix") end)
-- keymap.set("n", "<leader>xl", function() trouble.toggle("loclist") end)
-- keymap.set("n", "gR", function() trouble.toggle("lsp_references") end)

keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
  { desc = "Buffer Diagnostics (Trouble)" })
keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
keymap.set("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
  { desc = "LSP Definitions / references / ... (Trouble)" })
keymap.set("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
keymap.set("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })
