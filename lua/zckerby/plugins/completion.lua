--==================================================================================================
-- COMPLETION  (blink.cmp + LuaSnip + friendly-snippets)
--   Loaded BEFORE lsp.lua so it can hand capabilities to the language servers.
--==================================================================================================

vim.pack.add({
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
  "https://github.com/L3MON4D3/LuaSnip",
  "https://github.com/rafamadriz/friendly-snippets",
})

require("blink.cmp").setup({
  keymap = {
    preset = "none",
    ["<C-Space>"] = { "show", "hide" },
    ["<C-j>"]     = { "select_next", "fallback" },
    ["<C-k>"]     = { "select_prev", "fallback" },
    -- super-tab: accept the top/selected item if the menu is open; otherwise jump a snippet
    -- placeholder; otherwise act like a normal Tab.
    ["<Tab>"]     = { "select_and_accept", "snippet_forward", "fallback" },
    ["<S-Tab>"]   = { "snippet_backward", "fallback" },
    -- Enter only accepts if you've deliberately selected something (preselect is off below),
    -- so it falls through to a real newline the rest of the time.
    ["<CR>"]      = { "accept", "fallback" },
    ["<C-e>"]     = { "hide", "fallback" },
  },
  appearance = { nerd_font_variant = "mono" },
  completion = {
    menu = { auto_show = true },
    list = { selection = { preselect = false, auto_insert = false } },
    documentation = { auto_show = true, auto_show_delay_ms = 200 },
  },
  sources = { default = { "lsp", "path", "snippets", "buffer" } },
  snippets = { preset = "luasnip" },
  fuzzy = {
    implementation = "prefer_rust",
    prebuilt_binaries = { download = true },
  },
})

-- load the friendly-snippets collection into LuaSnip
require("luasnip.loaders.from_vscode").lazy_load()
