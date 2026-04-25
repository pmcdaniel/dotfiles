return {
    {
        'mason-org/mason.nvim',
        cmd = 'Mason',
        build = ':MasonUpdate',
        opts = {},
    },
    {
        'mason-org/mason-lspconfig.nvim',
        lazy = false,
        dependencies = {
            'mason-org/mason.nvim',
            'neovim/nvim-lspconfig',
        },
        config = function()
            require('config.plugins.mason-lspconfig')
        end,
    },
    {
        'saghen/blink.cmp',
        lazy = false,
        version = '1.*',
        opts = function()
            return require('config.plugins.blink')
        end,
        opts_extend = { 'sources.default' },
    },
    {
        'neovim/nvim-lspconfig',
        lazy = false,
        dependencies = {
            'mason-org/mason-lspconfig.nvim',
            'saghen/blink.cmp',
        },
        config = function()
            require('config.lsp').setup()
        end,
    },
}

