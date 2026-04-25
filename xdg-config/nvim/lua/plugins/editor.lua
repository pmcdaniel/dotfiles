return {
    {
        'lewis6991/gitsigns.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            require('config.plugins.gitsigns')
        end,
    },
    {
        'folke/todo-comments.nvim',
        event = { 'BufReadPost', 'BufNewFile' },
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('config.plugins.todo-comments')
        end,
    },
    {
        'folke/trouble.nvim',
        cmd = 'Trouble',
        config = function()
            require('config.plugins.trouble')
        end,
        keys = {
            {
                '<leader>xx',
                '<cmd>Trouble diagnostics toggle<cr>',
                desc = 'Diagnostics (Trouble)',
            },
            {
                '<leader>xt',
                '<cmd>TodoTrouble<cr>',
                desc = 'Todo list (Trouble)',
            },
        },
    },
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        config = function()
            require('config.plugins.which-key')
        end,
        keys = {
            {
                '<leader>?',
                function()
                    require('which-key').show({ global = false })
                end,
                desc = "Buffer keymaps",
            },
            {
                '<C-w><space>',
                function()
                    require('which-key').show({ keys = '<C-w>', loop = true })
                end,
                desc = "Window keymaps",
            },
        },
    },
}
