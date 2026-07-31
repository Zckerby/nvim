# zckerby nvim config

A personal Neovim configuration built on Neovim 0.12+'s native `vim.pack` plugin manager
(no lazy.nvim, no packer). Native LSP via `vim.lsp.config`/`vim.lsp.enable`, Mason for
installing servers/tools, blink.cmp for completion, Telescope for fuzzy finding, and
conform.nvim + nvim-lint for formatting/linting. Optomized for embedded systems 
programming and web dev toolchain. Java JDTLS is included but Java lsp is hard
to get working so Java development is not recommended. 

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
- **Node.js** — the JS/TS/Astro/Tailwind/HTML/CSS language servers.
- **A JDK** — `jdtls` for Java/Spring.
- **Python** — `pyright`, plus `black`/`isort` formatting (mason installs the tools).

## First-launch checklist

- `:checkhealth` — confirms toolchain bits are found.
- `:Mason` — watch servers + tools install; re-run `:MasonToolsInstall` if needed.
- `:Pack` / `:Pack update` — manage plugins; commit `nvim-pack-lock.json` to pin versions.

## Controls / Keybindings

Leader key is **Space**. `<leader>` below means Space. Timing note: `<leader>f`
(format) shares a prefix with the `<leader>f*` Telescope group, so Neovim waits
~500ms after `<leader>f` alone to see if a second key is coming — that's expected,
not a hang.

### General

| Key | Action |
| --- | --- |
| `<leader>sn` | Save without triggering format-on-save (plain `:w` still formats) |
| `x` | Delete char under cursor without clobbering the yank register |
| `<C-d>` / `<C-u>` | Half-page down/up, cursor stays centered |
| `n` / `N` | Next/previous search match, stays centered |
| `<Esc>` | Clear search highlight |

### Buffers

| Key | Action |
| --- | --- |
| `<Tab>` / `<S-Tab>` | Next / previous buffer |
| `<leader>x` | Close current buffer |
| `<leader>b` | New empty buffer |

### Splits & window navigation

| Key | Action |
| --- | --- |
| `<leader>v` | Split vertically |
| `<leader>h` | Split horizontally |
| `<leader>se` | Equalize split sizes |
| `<leader>xs` | Close current split |
| `<C-h>/<C-j>/<C-k>/<C-l>` | Move focus left/down/up/right between splits |

### Tabs

| Key | Action |
| --- | --- |
| `<leader>to` | Open new tab |
| `<leader>tx` | Close tab |
| `<leader>tn` / `<leader>tp` | Next / previous tab |

### Editing

| Key | Action |
| --- | --- |
| `<leader>lw` | Toggle line wrap |
| `<` / `>` (visual) | Indent/outdent and stay in visual mode |
| `p` (visual) | Paste over selection without losing your yank |
| `<A-j>` / `<A-k>` (visual) | Move selected lines down/up, re-indented |

### File explorer (nvim-tree)

| Key | Action |
| --- | --- |
| `<leader>e` | Toggle the file tree |
| `<leader>E` | Focus the tree (or jump back to the editor if already in it) |

### Fuzzy finder (Telescope)

| Key | Action |
| --- | --- |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (needs `rg`) |
| `<leader>fb` | List open buffers |
| `<leader>fh` | Search help tags |

### LSP (active once a language server attaches to the buffer)

| Key | Action |
| --- | --- |
| `K` | Hover docs |
| `gd` | Go to definition (via Telescope) |
| `gr` | Find references (via Telescope) |
| `gD` | Go to declaration |
| `<leader>gS` | Go to definition in a new vertical split |
| `<leader>ca` | Code action |
| `<leader>rn` | Rename symbol |
| `<leader>oi` | Organize imports, then format (where the server supports it) |

### Diagnostics (works with or without an LSP attached)

| Key | Action |
| --- | --- |
| `[d` / `]d` | Jump to previous/next diagnostic (floats it) |
| `<leader>pd` / `<leader>nd` | Jump to previous/next diagnostic (no float) |
| `<leader>d` | Show diagnostic under cursor |
| `<leader>D` | Show all diagnostics on current line |
| `<leader>q` | Send diagnostics to the location list |

### Formatting

| Key | Action |
| --- | --- |
| `<leader>f` | Format buffer (normal or visual mode) — also happens automatically on `:w` |

### Completion (insert mode, blink.cmp)

| Key | Action |
| --- | --- |
| `<C-Space>` | Show/hide completion menu |
| `<C-j>` / `<C-k>` | Next / previous completion item |
| `<Tab>` | Accept selected item, or jump forward in a snippet, or plain Tab |
| `<S-Tab>` | Jump backward in a snippet, or plain Shift-Tab |
| `<CR>` | Accept only if an item is actively selected; otherwise a normal newline |
| `<C-e>` | Dismiss the completion menu |

### Themes

Run `:Themery` to open the interactive theme picker (arrow keys + Enter, live preview).
Available themes include several Jellybeans, OneDark, Kanagawa, Nord, and Rosé Pine variants.

## TODO once you know your embedded toolchain

`clangd` is generic right now. It reads `compile_commands.json` from your CMake
build (`cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ...`). When you know the compiler
at Pitch, add a query-driver line in `lua/zckerby/plugins/lsp.lua` under the clangd
`cmd`, e.g. `"--query-driver=/usr/bin/arm-none-eabi-*"` (or the Windows path to your
toolchain's `bin/*`).

## Changelog

### 2026-07-31

- Config health check: verified every `lua/zckerby/**/*.lua` file loads headlessly
  with no errors and all `vim.pack` plugins install/resolve cleanly.
- Removed stale AI-completion documentation for a feature that was never actually
  wired into the config.
- Rewrote README with a full keybindings/controls reference for new users and
  moved the "what changed" history into this changelog.

### Neovim 0.12 / vim.pack migration

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
- bufferline dropped; `showtabline` set to 1.
