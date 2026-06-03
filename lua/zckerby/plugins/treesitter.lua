--==================================================================================================
-- TREESITTER   (nvim-treesitter `main` branch -- the rewrite; requires Neovim 0.12+)
--==================================================================================================

-- Run :TSUpdate after install/update. vim.pack has NO `build` key, so this is done via PackChanged.
-- Registered BEFORE vim.pack.add so it also fires on first install.
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "nvim-treesitter"
      and (ev.data.kind == "install" or ev.data.kind == "update") then
      if not ev.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      vim.cmd("TSUpdate")
    end
  end,
})

vim.pack.add({
  -- NOTE: `version = "main"`, NOT `branch` -- vim.pack ignores a `branch` key.
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

local ensure_installed = {
  "vim", "vimdoc", "lua",
  "c", "cpp", "cmake",
  "java",
  "javascript", "typescript", "tsx", "astro",
  "html", "css", "json", "bash",
  "python", "yaml", "markdown", "markdown_inline",
}

-- install() is a no-op for parsers that are already present, and runs async.
require("nvim-treesitter").install(ensure_installed)

-- start treesitter highlighting (+ indentation) per buffer when a parser is available
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("zckerby_treesitter", { clear = true }),
  callback = function(args)
    local filetype = args.match
    local lang = vim.treesitter.language.get_lang(filetype)
    if lang and vim.treesitter.language.add(lang) then
      vim.treesitter.start(args.buf)
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
