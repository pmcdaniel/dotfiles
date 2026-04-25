return {
    {
        'ellisonleao/gruvbox.nvim',
        name = 'gruvbox',
        priority = 1000,
        lazy = false,
        config = function()
            require('config.plugins.gruvbox')
        end,
    },
    {
        'nvim-mini/mini.icons',
        version = '*',
        lazy = true,
        init = function()
            package.preload['nvim-web-devicons'] = function()
                require('mini.icons').mock_nvim_web_devicons()
                return package.loaded['nvim-web-devicons']
            end
        end,
    },
    {
        'folke/snacks.nvim',
        priority = 1000,
        lazy = false,
        keys = {
            -- Top Pickers & Explorer
            { '<leader>,',       function() Snacks.picker.buffers() end,               desc = 'Buffers' },
            { '<leader>/',       function() Snacks.picker.grep() end,                  desc = 'Grep' },
            { '<leader>e',       function() Snacks.explorer() end,                     desc = 'File Explorer' },
            -- Find
            { '<leader>ff',      function() Snacks.picker.files() end,                 desc = 'Find Files' },
            { '<leader>fg',      function() Snacks.picker.git_files() end,             desc = 'Find Git Files' },
            --Grep / Search
            { '<leader>sb',      function() Snacks.picker.lines() end,                 desc = 'Buffer Lines' },
            { '<leader>sB',      function() Snacks.picker.grep_buffers() end,          desc = 'Grep Open Buffers' },
            { '<leader>sg',      function() Snacks.picker.grep() end,                  desc = 'Grep' },
            { '<leader>sw',      function() Snacks.picker.grep_word() end,             desc = "Visual selection or word", mode = { 'n', 'x' } },
        },
        config = function()
            require('config.plugins.snacks')
        end,
    },
    {
        'akinsho/bufferline.nvim',
        event = 'VeryLazy',
        version = '*',
        dependencies = { 'nvim-mini/mini.icons' },
        config = function()
            require('config.plugins.bufferline')
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        event = 'VeryLazy',
        dependencies = { 'nvim-mini/mini.icons' },
        config = function()
            require('config.plugins.lualine')
        end,
    },
}
