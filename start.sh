#!/usr/bin/env bash

# set -euo pipefail

# Wait for npm to be ready
while ! command -v npm &>/dev/null; do
  echo "Waiting for npm to be available..."
  sleep 1
done

# Start neovim healchcheck
nvim --headless '+checkhealth' +qall 2>&1 | tee nvim_health_test.log
if grep -qi "ERROR" nvim_health_test.log; then
  echo "Neovim health check failed. Please check nvim_health_test.log for details."
  exit 1
else
  echo "Neovim health check passed."
fi

# Run Lazy plugin sync test
nvim --headless -c 'lua require("lazy").sync({ wait = true })' +qa 2>&1 | tee nvim_lazy_test.log
if grep -qi "ERROR" nvim_lazy_test.log; then
  echo "Lazy plugin sync test failed. Please check nvim_lazy_test.log for details."
  exit 1
else
  echo "Lazy plugin sync test passed."
fi

declare -A test_results
declare -a test_files=(
  "test/lsp_basedpyright_test.lua"
  "test/lsp_jsonls_test.lua"
  "test/lsp_lua_ls_test.lua"
  "test/lsp_terraformls_test.lua"
  "test/lsp_yamlls_test.lua"
)

for test_file in "${test_files[@]}"; do
  log_file="${test_file}_log"
  nvim --headless -c "luafile $test_file" 2>&1 | tee "$log_file"

  if grep -qi "ERROR: LSP did not attach within timeout" "$log_file"; then
    echo "Test failed for $test_file. Check $log_file for details."
    test_results["$test_file"]="failed"
  else
    echo "Test passed for $test_file."
    test_results["$test_file"]="passed"
  fi
done

# Check if any test failed
failed=false
for result in "${test_results[@]}"; do
  if [ "$result" = "failed" ]; then
    failed=true
    break
  fi
done

if [ "$failed" = true ]; then
  echo "One or more tests failed."
  exit 1
else
  echo "All tests passed."
  exit 0
fi
