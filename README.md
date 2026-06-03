# zckerby nvim config (refreshed for Neovim 0.12 + vim.pack)

## Install

1. Back up your current config:
   ```sh
   mv ~/.config/nvim ~/.config/nvim.bak
   ```
   (On Windows: `~/AppData/Local/nvim`.)
2. Drop this folder in its place so you have `~/.config/nvim/init.lua`.
3. Launch `nvim`. The first run installs every plugin, downloads the blink fuzzy
   binary, compiles treesitter parsers, and kicks off mason installs. Give it a
   minute, then `:restart` (or quit and reopen).

## Prerequisites (what each piece needs on PATH)

- **Neovim 0.12.0+** — required by vim.pack and the treesitter `main` branch.
- **git, curl, tar** — plugin install + parser downloads.
- **A C compiler** (gcc/clang) and **tree-sitter CLI** — treesitter parser compilation.
- **ripgrep (`rg`)** — Telescope live grep (`Space f g`).
- **make + C compiler** — to build telescope-fzf-native (optional; Telescope works without it).
- **Node.js** — Copilot, and the JS/TS/Astro/Tailwind/HTML/CSS language servers.
- **A JDK** — `jdtls` for Java/Spring.
- **Python** — `pyright`, plus `black`/`isort` formatting (mason installs the tools).

## First-launch checklist

- `:checkhealth` — confirms toolchain bits are found.
- `:Mason` — watch servers + tools install; re-run `:MasonToolsInstall` if needed.
- `:Pack` / `:Pack update` — manage plugins; commit `nvim-pack-lock.json` to pin versions.
- `:Copilot setup` — authenticate Copilot once (it stays OFF until you toggle it).

## TODO once you know your embedded toolchain

`clangd` is generic right now. It reads `compile_commands.json` from your CMake
build (`cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ...`). When you know the compiler
at Pitch, add a query-driver line in `lua/zckerby/plugins/lsp.lua` under the clangd
`cmd`, e.g. `"--query-driver=/usr/bin/arm-none-eabi-*"` (or the Windows path to your
toolchain's `bin/*`).

## What changed from the old config

- Migrated fully to `vim.pack`; removed leftover lazy.nvim specs (nerdicons, the
  old bufferline spec) and the unused/empty files.
- Folders: `vimOptions/` -> `core/`, `version2/` -> `plugins/`.
- Merged `options.lua` + `options2.lua` into one `core/options.lua`
  (restored `clipboard=unnamedplus`, `splitright`, `undofile`; dropped `lazyredraw`).
- **Autocomplete fixed**: added an accept key (Tab = accept, Enter = accept-if-selected).
- Treesitter: `version = "main"` (was an ignored `branch` key) + `TSUpdate` via a
  PackChanged hook; added tsx/astro/java/cmake/markdown parsers.
- Telescope: fzf-native now actually compiles (PackChanged hook).
- LSP: added jdtls, astro, tailwindcss, html, emmet, cmake; fixed the broken
  fzf-lua reference (now Telescope); removed the dead `caps` no-ops and the bad
  `stylua` entry in mason-lspconfig.
- Replaced `efm` with `conform.nvim` (format) + `nvim-lint` (lint); tools auto-install.
- Copilot starts disabled, toggle with `Space c p`, no longer steals Tab.
- bufferline dropped; `showtabline` set to 1.
