--==================================================================================================
-- COPILOT   (off by default; toggle on when you actually want suggestions)
--==================================================================================================

vim.pack.add({
  "https://github.com/github/copilot.vim",
})

-- start disabled and stop Copilot from stealing <Tab> (so it can't fight blink's accept key)
vim.g.copilot_enabled = false
vim.g.copilot_no_tab_map = true

-- accept the current Copilot suggestion (only relevant while Copilot is ON)
vim.keymap.set("i", "<C-l>", 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false,
  silent = true,
  desc = "Accept Copilot suggestion",
})

-- toggle Copilot on / off
local copilot_on = false
vim.keymap.set("n", "<leader>cp", function()
  copilot_on = not copilot_on
  vim.cmd(copilot_on and "Copilot enable" or "Copilot disable")
  vim.notify("Copilot " .. (copilot_on and "ON" or "OFF"))
end, { desc = "Toggle Copilot" })

-- Run :Copilot setup once to authenticate. Requires Node.js.
