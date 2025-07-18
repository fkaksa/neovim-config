local mason = require("mason")
local registry = require("mason-registry")

local interval = 1000    -- ms between checks
local timeout = 10000000 -- max total wait in ms
local elapsed = 0

-- Get the list of servers from mason-lspconfig
local servers_to_check = {
  "yaml-language-server",
  "bash-language-server",
  "dockerfile-language-server",
  "json-lsp",
  "lua-language-server",
  "basedpyright",
  "terraform-ls",
}
-- Start polling timer
local timer = vim.uv.new_timer() or vim.loop.new_timer()

local function ensure_installed()
  local all_installed = true
  for _, name in ipairs(servers_to_check) do
    if not registry.is_installed(name) then
      all_installed = false
      local ok, pkg = pcall(registry.get_package, name)
      if ok then
        print("📦 Installing " .. name)
        pkg:install()
        print()
      else
        print("❌ Failed to get package for " .. name)
        timer:stop()
        os.exit(1)
      end
    else
      print("✅ " .. name .. " already installed")
    end
  end
  if all_installed then
    print("✅ All LSP servers are installed.")
    timer:stop()
    os.exit(0)
  elseif elapsed >= timeout then
    print("❌ Timed out waiting for LSP servers to install.")
    timer:stop()
    os.exit(1)
  else
    print("⏳ Waiting for Mason to finish...")
    elapsed = elapsed + interval
  end
end

timer:start(0, interval, vim.schedule_wrap(ensure_installed))
