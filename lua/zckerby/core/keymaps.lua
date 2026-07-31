--==================================================================================================
-- KEYMAPS   (leader = Space)
--==================================================================================================

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

local opts = { noremap = true, silent = true }

-- save without auto-formatting (plain :w handles a normal, formatted save)
vim.keymap.set("n", "<leader>sn", "<cmd>noautocmd w<CR>", opts)

-- delete a char without clobbering the yank register
vim.keymap.set("n", "x", '"_x', opts)

-- half-page jumps stay centered
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- search results stay centered
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

-- clear search highlight
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)

-- buffers ----------------------------------------------------------------------------------------
vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", opts)
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>", opts)
vim.keymap.set("n", "<leader>x", "<cmd>bdelete!<CR>", opts) -- close buffer
vim.keymap.set("n", "<leader>b", "<cmd>enew<CR>", opts) -- new buffer

-- splits: create ---------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>v", "<C-w>v", opts) -- split vertically
vim.keymap.set("n", "<leader>h", "<C-w>s", opts) -- split horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", opts) -- equalize splits
vim.keymap.set("n", "<leader>xs", "<cmd>close<CR>", opts) -- close current split

-- splits: move between (NEW) ---------------------------------------------------------------------
vim.keymap.set("n", "<C-h>", "<C-w>h", opts) -- move left
vim.keymap.set("n", "<C-j>", "<C-w>j", opts) -- move down
vim.keymap.set("n", "<C-k>", "<C-w>k", opts) -- move up
vim.keymap.set("n", "<C-l>", "<C-w>l", opts) -- move right

-- tabs -------------------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", opts)
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", opts)
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", opts)
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", opts)

-- toggle line wrap
vim.keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>", opts)

-- visual: stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- visual: paste over a selection without losing the yank
vim.keymap.set("v", "p", '"_dP', opts)

-- visual: move the selection up/down a line, re-indenting (NEW)
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

--==================================================================================================
-- DIAGNOSTICS   (global -- works for both LSP and linters; defined once, here)
--==================================================================================================
vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>pd", function()
	vim.diagnostic.jump({ count = -1 })
end, { desc = "Previous diagnostic" })
vim.keymap.set("n", "<leader>nd", function()
	vim.diagnostic.jump({ count = 1 })
end, { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>d", function()
	vim.diagnostic.open_float({ scope = "cursor" })
end, { desc = "Diagnostic under cursor" })
vim.keymap.set("n", "<leader>D", function()
	vim.diagnostic.open_float({ scope = "line" })
end, { desc = "Line diagnostics" })
vim.keymap.set("n", "<leader>q", function()
	vim.diagnostic.setloclist()
end, { desc = "Diagnostics list" })
