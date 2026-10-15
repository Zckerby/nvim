#!/usr/bin/env bash
#
# Installs external CLI dependencies this Neovim config needs but that its own
# package manager (vim.pack for plugins, Mason for LSP servers/formatters/linters)
# does not provide. Uses Homebrew.
#
set -euo pipefail

if ! command -v brew >/dev/null 2>&1; then
	echo "Homebrew not found on PATH. Install it first: https://brew.sh" >&2
	exit 1
fi

# formula => reason (kept as parallel arrays for readability of output)
declare -A DEPS=(
	[git]="clones plugins for vim.pack and tools for Mason"
	[curl]="Mason uses it to download LSP servers/tools"
	[unzip]="Mason uses it to extract downloaded tools"
	[make]="builds telescope-fzf-native.nvim on install"
	[gcc]="C compiler needed to build telescope-fzf-native.nvim"
	[node]="runtime for ts_ls, tailwindcss, bashls, html/cssls, emmet, astro, prettierd, eslint_d, pyright"
	[python3]="needed by the black/isort formatters"
	[openjdk]="JVM required to run jdtls (Java LSP)"
	[ripgrep]="powers Telescope live_grep (<leader>fg)"
	[fd]="fast, gitignore-aware file listing for Telescope/nvim-tree"
	[xclip]="system clipboard provider for clipboard=unnamedplus (X11)"
	[wl-clipboard]="system clipboard provider for clipboard=unnamedplus (Wayland)"
)

to_install=()
for formula in "${!DEPS[@]}"; do
	if brew list --formula "$formula" >/dev/null 2>&1; then
		echo "ok      $formula (already installed)"
	else
		echo "missing $formula -- ${DEPS[$formula]}"
		to_install+=("$formula")
	fi
done

if [ "${#to_install[@]}" -eq 0 ]; then
	echo
	echo "Everything is already installed."
	exit 0
fi

echo
echo "Installing: ${to_install[*]}"
brew install "${to_install[@]}"

echo
echo "Done. Open nvim and run :Mason to let it pull in the LSP servers/formatters/linters themselves."
