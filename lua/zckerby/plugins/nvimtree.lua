--==================================================================================================
-- FILE TREE  (nvim-tree)
--==================================================================================================

vim.pack.add({
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-tree/nvim-tree.lua",
})

require("nvim-tree").setup({
  view = { width = 35 },
  filters = { dotfiles = false },
  renderer = { group_empty = true },
})

-- toggle the tree open / closed
vim.keymap.set("n", "<leader>e", function()
  require("nvim-tree.api").tree.toggle()
end, { desc = "Toggle file tree" })

-- jump the cursor in/out of the tree WITHOUT closing it
vim.keymap.set("n", "<leader>E", function()
  if vim.bo.filetype == "NvimTree" then
    vim.cmd("wincmd p") -- hop back to the editor
  else
    require("nvim-tree.api").tree.focus() -- hop into the tree (opens it if needed)
  end
end, { desc = "Focus / leave file tree" })

-- transparent tree background (applied after the colorscheme loads)
for _, group in ipairs({ "NvimTreeNormal", "NvimTreeNormalNC", "NvimTreeEndOfBuffer", "NvimTreeSignColumn" }) do
  vim.api.nvim_set_hl(0, group, { bg = "none" })
end
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { fg = "#2a2a2a", bg = "none" })
