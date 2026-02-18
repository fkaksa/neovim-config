#!/usr/bin/env bash

# Build the Docker image
echo "Building Docker image for Neovim test environment..."
docker build --platform linux/amd64 -t nvim-test .
echo "Docker image built successfully."
