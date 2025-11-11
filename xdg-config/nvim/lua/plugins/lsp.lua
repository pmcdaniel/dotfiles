return {
    "neovim/nvim-lspconfig",
    opts = {
        servers = {
            lua_ls = {},
            basedpyright = {
                settings = {
                    basedpyright = {
                        analysis = { typeCheckingMode = "standard", },
                    },
                },
            },
        }
    },
    config = function(plugin, opts)
        vim.diagnostic.enable = true
        vim.diagnostic.config({
            virtual_text = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}

