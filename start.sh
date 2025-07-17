#!/usr/bin/env bash

set -euo pipefail

# Wait for npm to be ready
while ! command -v npm &>/dev/null; do
  echo "Waiting for npm to be available..."
  sleep 1
done

# Start neovim and check if log contains errors
nvim --headless '+checkhealth' +qall 2>&1 | tee nvim_health.log
if grep -qi "ERROR" nvim_health.log; then
  echo "Neovim health check failed. Please check nvim_health.log for details."
  exit 1
else
  echo "Neovim health check passed."
fi
