vim.pack.add{
    "https://github.com/zaldih/themery.nvim",
    "https://github.com/wtfox/jellybeans.nvim",
    "https://github.com/olimorris/onedarkpro.nvim",
}
require("themery").setup({
    themes = {
        {name = "Jellybean Light", colorscheme = "jellybeans-light",},
        {name = "Jellybean Dark", colorscheme = "jellybeans-muted"},
        {name = "Jellybean Mid Light", colorscheme = "jellybeans-mono-light"},
        {name = "Vim Trip", colorscheme = "vim"},
        {name = "Jellybeans Dark Mono" , colorscheme = "jellybeans-muted"},
        {name = "Very Dark", colorscheme = "onedark_dark"},
        {name = "Light One", colorscheme = "onelight"}
  },
  livePreview = true,
})
