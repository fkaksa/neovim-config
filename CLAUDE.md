<!-- project-template: 48 -->
# Neovim Configuration

## About

Personal Neovim configuration in Lua, managed with [lazy.nvim](https://github.com/folke/lazy.nvim). Provides plugin setup, LSP configurations, keymaps, and a Docker-based test harness for reproducible validation. Deployed to `~/.config/nvim` (XDG).

## Tech Stack

Lua, Neovim (0.12.x), lazy.nvim (plugin manager), Mason (LSP/tool installer), Docker (test environment). Theme: catppuccin-mocha.

---

## Current Status

| Story | Status | Notes |
|-------|--------|-------|
| Neovim 0.11.5 upgrade | Done | Merged via PR #3 (45bf2b1) |
| Disable Copilot plugins | Done | Copilot removed from setup (474e453) |
| Neovim 0.12.2 upgrade | In Progress | Branch `feature/nvim-0.12`; Docker harness green, host upgraded (brew 0.12.2, plugins synced); commits pending |

**Legend:** Open | In Progress | Done

**Next Step:** Commit the 0.12 upgrade changes on `feature/nvim-0.12`, do an interactive smoke test (`:checkhealth`, LSP, `gcc` commenting), then open a PR to master.

### Future

| Todo | Priority | Problem | Solution |
|------|----------|---------|----------|
| indent-blankline + nvim 0.11 | Low | Possible incompatibility ([issue #988](https://github.com/lukas-reineke/indent-blankline.nvim/issues/988)) | Monitor / test |
| Evaluate toggleterm.nvim | Low | Terminal management | Trial plugin |

---

## Recent Decisions

| Date | Decision | Why |
|------|----------|-----|
| 2026-06-10 | CLAUDE.md tracked Solo (gitignored) | Personal config repo, not shared |
| 2026-06-10 | Harness health check reads the `health://` buffer, not stdout | Since nvim 0.12 headless `:checkhealth` prints only progress to stdout; grepping stdout passes vacuously |
| 2026-06-10 | Ignore "is not in runtimepath" in health check | False positive: archived nvim-treesitter main has a trailing-slash comparison bug; parsers/queries verified working |
| 2026-06-10 | After treesitter parser updates on macOS, re-sign parsers (`codesign -f -s - ~/.local/share/nvim/site/parser/*.so`) | In-place overwritten .so files get SIGKILLed by the kernel (stale code-signature cache on Apple Silicon) |

---

## Project Instructions

<!-- PROJECT INSTRUCTIONS START -->
- This config is deployed to `~/.config/nvim`. The working dir `~/xdg/nvim` is the source repo.
- Plugin configs live as one file per plugin in `lua/plugins/`; lazy.nvim auto-loads the whole `plugins` directory.
- Disabled plugins use a `.disable` suffix so lazy.nvim skips them — don't delete, rename when reactivating.
- Each LSP server has its own file in `lua/lsp/`; servers are installed via Mason.
- `ignore/` and `logs/` are gitignored scratch areas — don't rely on their contents.
- Validate changes with the Docker test harness (see Development), not just by eyeballing — it catches health-check and LSP-attach regressions.
<!-- PROJECT INSTRUCTIONS END -->

---

## Architecture

Entry point `init.lua` loads three modules in order:
1. `require('lsp')` — `lua/lsp/init.lua` sets up LSP servers (one file per server).
2. `require('core')` — `lua/core/` provides options, keymaps, filetypes.
3. `require('package-manager')` — bootstraps lazy.nvim and calls `require("lazy").setup("plugins", ...)`, which loads every file in `lua/plugins/`.

After plugins load, the colorscheme is applied and `after/plugin/` post-config runs.

Plugins are pinned via `lazy-lock.json`. LSP servers and tools are installed through Mason. The test harness (`start.sh` inside Docker) runs a headless Neovim health check, a lazy sync, a Mason install check, and per-LSP attach tests.

---

## Files

```
├── init.lua                  # Entry point: loads lsp, core, package-manager
├── lua/
│   ├── core/                 # options.lua, keymaps.lua, filetypes.lua, init.lua
│   ├── lsp/                  # One file per LSP server + init.lua
│   ├── plugins/              # One file per plugin (lazy.nvim auto-loaded)
│   └── package-manager.lua   # lazy.nvim bootstrap + setup
├── after/plugin/             # Post-plugin configuration
├── tests/                    # Headless LSP/Mason test scripts (run via start.sh)
├── Dockerfile                # Reproducible test environment
├── docker-build.sh           # Build the test image
├── start.sh                  # Test entrypoint (runs inside container)
├── lazy-lock.json            # Plugin version lockfile
├── .luarc.json               # lua-language-server config
└── docs/records/             # Design decisions and feature specs (created by /design)
```

---

## Development

```bash
# Build the Docker test image
./docker-build.sh

# Run the full test harness (health check, lazy sync, Mason, LSP attach tests)
docker run --rm --platform linux/amd64 nvim-test

# Run a single test locally (headless)
nvim --headless -c "luafile tests/mason_test.lua"

# Update plugins
nvim -c "Lazy sync"
```

Remote: `git@github.com:fkaksa/neovim-config.git`
