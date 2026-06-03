--==================================================================================================
-- FUZZY FINDER  (telescope)
--==================================================================================================

-- Compile telescope-fzf-native after install/update. vim.pack has no `build` key, so use PackChanged.
-- (Requires `make` + a C compiler on PATH. On Windows without them, fzf just won't load -- telescope
--  still works, sorting is a touch slower. The pcall below swallows that gracefully.)
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "telescope-fzf-native.nvim"
      and (ev.data.kind == "install" or ev.data.kind == "update") then
      vim.system({ "make" }, { cwd = ev.data.path })
    end
  end,
})

vim.pack.add({
  -- version pin removed (your old "v0.2.1" may not resolve). Pin once you confirm a tag with :Pack.
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
})

require("telescope").setup({
  extensions = { fzf = {} },
})
pcall(require("telescope").load_extension, "fzf")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" }) -- needs ripgrep (rg)
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
