vim.g.mapleader = " "
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)
-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
--Window Management
vim.keymap.set('n', '<leader>v', '<C-w>v', opts) -- split window vertically
vim.keymap.set('n', '<leader>h', '<C-w>s', opts) -- split window horizontally
vim.keymap.set('n', '<leader>se', '<C-w>=', opts) -- make split windows equal width & height
vim.keymap.set('n', '<leader>xs', ':close<CR>', opts) -- close current split window
-- Tabs
vim.keymap.set('n', '<leader>to', ':tabnew<CR>', opts) -- open new tab
vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', opts) -- close current tab
vim.keymap.set('n', '<leader>tn', ':tabn<CR>', opts) --  go to next tab
vim.keymap.set('n', '<leader>tp', ':tabp<CR>', opts) --  go to previous tab
-- Toggle line wrapping
vim.keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', opts)
-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)
