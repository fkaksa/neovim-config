# Neovim Configuration

This repository contains a custom Neovim configuration designed to enhance the development experience. It includes plugins, key mappings, and settings for improved productivity and usability.

## Features

- **Plugin Management**: Efficiently manages plugins using a package manager.
- **Custom Keymaps**: Predefined key mappings for faster navigation and editing.
- **Language Support**: Configurations for multiple programming languages.
- **UI Enhancements**: Themes, status lines, and other visual improvements.
- **Utilities**: Tools like undotree, autopairs, and more for better workflow.

| Keymap               | Mode   | Description                          |
|----------------------|--------|--------------------------------------|
| `<leader>ff`         | Normal | Find files using Telescope           |
| `<leader>fg`         | Normal | Live grep using Telescope            |
| `<leader>fb`         | Normal | List buffers using Telescope         |
| `<leader>fh`         | Normal | Find help tags using Telescope       |
| `<leader>u`          | Normal | Toggle Undotree                      |
| `<leader>q`          | Normal | Close the current buffer             |
| `<leader>p`          | Normal | Paste from system clipboard          |
| `<leader>y`          | Visual | Yank to system clipboard             |
| `<leader>c`          | Normal | Comment/uncomment lines              |
| `<leader>e`          | Normal | Open file explorer (Oil plugin)      |
| `gv`                 | Visual | Reselect previously selected text    |
| `<S-h>`              | Normal | Switch to previous buffer            |
| `<S-l>`              | Normal | Switch to next buffer                |
| `<leader><tab>d`     | Normal | Close current buffer                 |
| `<leader><tab>D`     | Normal | Close all buffers except active one  |
| `<C-h>`              | Normal | Navigate to left window              |
| `<C-j>`              | Normal | Navigate to lower window             |
| `<C-k>`              | Normal | Navigate to upper window             |
| `<C-l>`              | Normal | Navigate to right window             |
| `<leader>64`         | Normal | Decrypt selected string              |
| `<`                  | Visual | Indent left and reselect             |
| `>`                  | Visual | Indent right and reselect            |
| `<leader>yf`         | Normal | Copy absolute file path to clipboard |
| `<leader>yF`         | Normal | Copy relative file path to clipboard |
| `<leader>yd`         | Normal | Copy absolute directory path         |
| `<leader>yD`         | Normal | Copy relative directory path         |
| `<leader>qa`         | Normal | Add current line to quickfix list    |

## Directory Structure

```plaintext
├── lua/
│   ├── core/               # Core settings (options, keymaps, filetypes)
│   ├── plugins/            # Plugin configurations
│   └── package-manager.lua # Plugin manager setup
├── lsp/                    # Language Server Protocol configurations
├── after/plugin/           # Post-plugin configurations
├── init.lua                # Main entry point for Neovim
├── Dockerfile              # Docker setup for reproducible environments
├── .luarc.json             # Lua language server configuration
├── lazy-lock.json          # Lockfile for plugins
```

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/your-username/nvim-config.git ~/.config/nvim
   ```
2. Open Neovim and install plugins:
   ```bash
   nvim
   ```
   Then run `:Lazy` or the equivalent command for your package manager.

3. Enjoy your enhanced Neovim setup!

