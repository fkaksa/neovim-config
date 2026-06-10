#!/usr/bin/env bash

# set -x

TMPDIR=$(mktemp -d)
mkdir -p "$TMPDIR"
function cleanup {
  echo "Cleaning up..."
  rm -rf ${TMPDIR}
}
trap cleanup EXIT

# Wait for npm to be ready
while ! command -v npm &>/dev/null; do
  echo "Waiting for npm to be available..."
  sleep 1
done

# Start neovim healthcheck
# Since nvim 0.12 the headless checkhealth report is only written to the health://
# buffer (stdout gets progress messages only), so dump the buffer to a file.
nvim --headless '+checkhealth' \
  "+lua vim.fn.writefile(vim.fn.getbufline(vim.fn.bufnr('health://'), 1, '\$'), '${TMPDIR}/nvim_health_test.log')" \
  '+qa!' 2>&1
if [ ! -s "${TMPDIR}/nvim_health_test.log" ]; then
  echo "Neovim health check failed: no health report produced (nvim crashed during checkhealth?)."
  exit 1
fi
# Error lines in the health report look like "- ❌ ERROR ...". A plain case-insensitive
# "error" grep would also hit config dumps like 'log_level = "error"' and the per-section
# "1 ❌" summary counts, so anchor on the error line marker.
# The archived nvim-treesitter main branch always reports "is not in runtimepath"
# due to a trailing-slash comparison bug in its health check - ignore that line.
if grep -v "is not in runtimepath" "${TMPDIR}/nvim_health_test.log" | grep -qE "^- (❌ )?ERROR"; then
  echo "Neovim health check failed. Please check nvim_health_test.log for details."
  cat ${TMPDIR}/nvim_health_test.log
  exit 1
else
  echo "Neovim health check passed."
fi

# Run Lazy plugin sync test
nvim --headless -c 'lua require("lazy").sync({ wait = true })' +qa 2>&1 | tee ${TMPDIR}/nvim_lazy_test.log
if grep -qi "ERROR" ${TMPDIR}/nvim_lazy_test.log; then
  echo "Lazy plugin sync test failed. Please check nvim_lazy_test.log for details."
  cat ${TMPDIR}/nvim_lazy_test.log
  exit 1
else
  echo "Lazy plugin sync test passed."
fi

# Run Mason install command
nvim --headless -c "luafile tests/mason_test.lua" 2>&1 | tee ${TMPDIR}/nvim_mason_test.log
if [ $? -ne 0 ]; then
  echo "Mason install test failed. Please check nvim_mason_test.log for details."
  cat ${TMPDIR}/nvim_mason_test.log
  exit 1
else
  echo "Mason install test passed."
fi

declare -A test_results
declare -a test_files=($(find tests -type f -name "lsp_*_test.lua"))

for test_file in "${test_files[@]}"; do
  log_file="logs/${test_file}_log"
  mkdir -p "$(dirname "$log_file")"
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
