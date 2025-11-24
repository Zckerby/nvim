return {
    "zaldih/themery.nvim",
    lazy = false,
    config = function()
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
    end
  }
