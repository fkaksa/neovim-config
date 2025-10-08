--
-- This script tests/ if the 'basedpyright' LSP attaches to a Python file in Neovim.
--
-- usage:
-- 1. Ensure you have 'basedpyright' configured in your Neovim LSP settings.
-- 2. Place a Python file in the specified path.
-- -- Run the script using Neovim's command line:
--   :luafile tests/lsp_test.lua

local server_name = "yamlls"
local test_file = "tests/resources/test_file.yaml"

print("Test: Check if " .. server_name .. " has been attached to a file.")
print()

-- Timer for checking LSP attachment
local timeout = 5000 -- max wait time in ms
local interval = 200 -- check every X ms
local elapsed = 0

local timer = vim.uv.new_timer() or vim.loop.new_timer()

local function check_lsp()
  vim.cmd("edit " .. test_file) -- use a real file relevant to your LSP

  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients > 0 then
    for _, client in ipairs(clients) do
      if client.name == server_name then
        print(client.name .. " attached successfully")
        timer:stop()
        os.exit(0)
      end
    end
    print("ERROR: LSP did not attach within timeout.")
    timer:stop()
    os.exit(1)
  elseif elapsed >= timeout then
    print("ERROR: LSP did not attach within timeout.")
    timer:stop()
    os.exit(1)
  else
    elapsed = elapsed + interval
  end
end

timer:start(200, interval, vim.schedule_wrap(check_lsp))
