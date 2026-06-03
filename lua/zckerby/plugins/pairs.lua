--==================================================================================================
-- AUTOPAIRS + AUTO-CLOSE TAGS   (WebStorm-style bracket + HTML/JSX tag closing)
--   Loaded BEFORE completion.lua so blink's <CR> falls back to autopairs' smart newline
--   (e.g. pressing Enter inside {} opens an indented block).
--==================================================================================================

vim.pack.add({
  "https://github.com/windwp/nvim-autopairs",
  "https://github.com/windwp/nvim-ts-autotag",
})

-- () [] {} "" '' `` -- auto-closes pairs, treesitter-aware so it won't pair inside strings etc.
require("nvim-autopairs").setup({
  check_ts = true,
  ts_config = {
    lua = { "string" },
    javascript = { "template_string" },
  },
  disable_filetype = { "TelescopePrompt" },
  fast_wrap = {}, -- press Alt-e in insert mode to wrap the next item in a pair
})

-- <div> -> <div></div>, and rename the closing tag automatically when you edit the opening one.
-- Needs the treesitter parser for the filetype (html/tsx/astro/etc.) -- which you now have.
require("nvim-ts-autotag").setup({
  opts = {
    enable_close = true,           -- auto close tags
    enable_rename = true,          -- rename the matching tag when you change one
    enable_close_on_slash = false, -- don't also close when you type </
  },
})
