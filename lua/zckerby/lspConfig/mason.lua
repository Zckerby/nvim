return{
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = {
            servers = {
                lua_ls = {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = {"vim"},
                        },
                    },
                },
            },
        },
    },
        config = function()
            require("mason").setup()

            require("mason-lspconfig").setup({
                ensure_installed = {"lua_ls"}
            })
            vim.diagnostic.config({
                virtual_text = true,
                underline = true
            })
            vim.lsp.enable('lua_ls')
        end
    },
}


