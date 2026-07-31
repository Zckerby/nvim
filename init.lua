--==================================================================================================
-- zckerby :: init.lua   (Neovim 0.12+, built-in vim.pack)
--==================================================================================================

-- core (load first)
require("zckerby.core.options")
require("zckerby.core.keymaps")

-- plugins
require("zckerby.plugins.treesitter")
require("zckerby.plugins.themery")
require("zckerby.plugins.lualine")
require("zckerby.plugins.nvimtree")
require("zckerby.plugins.telescope")
require("zckerby.plugins.pairs") -- autopairs + autotag (before completion for <CR> fallback)
require("zckerby.plugins.completion") -- MUST load before lsp (provides completion capabilities)
require("zckerby.plugins.lsp")
require("zckerby.plugins.format")
