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
--  ui plugins
    require 'zckerby.ui.colortheme',--colorscheme of the window 
    require 'zckerby.ui.bufferline',
    require 'zckerby.ui.lualine',
    require 'zckerby.ui.neotree',
    require 'zckerby.ui.nerd',
    
    --plugins
    require 'zckerby.plugins.treesitter', 
--    lsp servers
--    require zckerby.lspConfig.lsp-config'
    require 'zckerby.lspConfig.mason'
--    require 'zckerby.lspConfig.mason-lsp'

})

