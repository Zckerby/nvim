return {
    "zaldih/themery.nvim",
    lazy = false,
    config = function()
      require("themery").setup({
          themes = {
              {name = "Day",
              colorscheme = "jellybeans-light",},
          },
          livePreview = true,
      })
    end
  }
