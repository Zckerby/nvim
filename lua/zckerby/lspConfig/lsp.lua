vim.pack.add({
    "https://www.github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/creativenull/efmls-configs-nvim",
    {
        src = "https://github.com/saghen/blink.cmp",
        branch = "main",
        build = ":TSUpdate",
    },
    "https://github.com/L3MON4D3/LuaSnip",
})

local function packadd(name)
    vim.cmd("packadd " .. name)
end
packadd("nvim-lspconfig")
packadd("mason.nvim")
packadd("efmls-configs-nvim")
packadd("blink.cmp")
packadd("LuaSnip")


 
