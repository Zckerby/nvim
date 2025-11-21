require ("zckerby.core.keymaps")
require ("zckerby.core.options")

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require('lazy').setup({
    require 'zckerby.plugins.neotree',
    require 'zckerby.plugins.colortheme', 
    require 'zckerby.plugins.nvterm',
    require 'zckerby.plugins.nerd',
    require 'zckerby.plugins.mason',
    require 'zckerby.languageSupport.assembly',
    require 'zckerby.plugins.bufferline', 
    require 'zckerby.plugins.lualine', 
    require 'zckerby.plugins.treesitter',
    require 'zckerby.plugins.telescope',
    require 'zckerby.plugins.lsp',
})
