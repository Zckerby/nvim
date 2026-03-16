vim.pack.add{
    "https://github.com/zaldih/themery.nvim",
    "https://github.com/wtfox/jellybeans.nvim",
    "https://github.com/olimorris/onedarkpro.nvim",
    {
      src = "https://github.com/rebelot/kanagawa.nvim",
    },
    {
      src = "https://github.com/navarasu/onedark.nvim",
      version = "v0.1.0",
    },
    "https://github.com/shaunsingh/nord.nvim",
    "https://github.com/rose-pine/neovim",
}
require("themery").setup({
    themes = {
        {name = "Jellybean Light", colorscheme = "jellybeans-light",},
        {name = "Jellybean Dark", colorscheme = "jellybeans-muted"},
        {name = "Jellybean Mid Light", colorscheme = "jellybeans-mono-light"},
        {name = "Vim Trip", colorscheme = "vim"},
        {name = "Jellybeans Dark Mono" , colorscheme = "jellybeans-muted"},
        {name = "Very Dark", colorscheme = "onedark_dark"},
        {name = "Light One", colorscheme = "onelight"},
        {name = "Kanagawa Lotus", colorscheme = "kanagawa-lotus"},
        {name = "Kanagawa Wave", colorscheme = "kanagawa-wave"},
        {name = "Kanagawa Dragon", colorscheme = "kanagawa-dragon"},
        {name = "onedark dark", colorscheme = "onedark_dark"},
        {name = "nord", colorscheme = "nord"},
        {name = "rose pine light", colorscheme = "rose-pine-dawn"},
        {name = "rose pine sunset", colorscheme = "rose-pine-moon"},
  },
  livePreview = true,
})
