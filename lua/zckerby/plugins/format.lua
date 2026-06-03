--==================================================================================================
-- FORMAT + LINT   (conform.nvim + nvim-lint -- replaces the old efm setup)
--   Tools are auto-installed by mason-tool-installer in lsp.lua.
--==================================================================================================

vim.pack.add({
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/mfussenegger/nvim-lint",
})

--------------------------------------------------------------------------------------------------
-- Formatting (conform)
--------------------------------------------------------------------------------------------------
local conform = require("conform")
conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
    javascript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
    astro = { "prettierd" },
    html = { "prettierd" },
    css = { "prettierd" },
    scss = { "prettierd" },
    json = { "prettierd" },
    jsonc = { "prettierd" },
    markdown = { "prettierd" },
    yaml = { "prettierd" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    sh = { "shfmt" },
    bash = { "shfmt" },
    -- java has no formatter listed -> falls back to the jdtls LSP formatter
  },
  -- Format on save. `<leader>sn` (noautocmd w) skips this; plain `:w` runs it.
  -- Set to false to disable, or use the manual <leader>f key below.
  format_on_save = { timeout_ms = 1000, lsp_format = "fallback" },
})

vim.keymap.set({ "n", "v" }, "<leader>f", function()
  conform.format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer" })

--------------------------------------------------------------------------------------------------
-- Linting (nvim-lint)
--------------------------------------------------------------------------------------------------
local lint = require("lint")
lint.linters_by_ft = {
  sh = { "shellcheck" },
  bash = { "shellcheck" },
  javascript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescript = { "eslint_d" },
  typescriptreact = { "eslint_d" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
  group = vim.api.nvim_create_augroup("zckerby_lint", { clear = true }),
  callback = function()
    require("lint").try_lint()
  end,
})
