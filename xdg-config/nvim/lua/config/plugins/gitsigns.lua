require('gitsigns').setup {
    current_line_blame = true,
    on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
            if vim.wo.diff then
                vim.cmd.normal({']c', bang = true})
            else
                gitsigns.nav_hunk('next')
            end
        end)

        map('n', '[c', function()
            if vim.wo.diff then
                vim.cmd.normal({ '[c', bang = true })
            else
                gitsigns.nav_hunk('prev')
            end
        end)

        -- Actions
        map('n', '<leader>ghs', gitsigns.stage_hunk)
        map('n', '<leader>ghr', gitsigns.reset_hunk)
        map('n', '<leader>ghS', gitsigns.stage_buffer)
        map('n', '<leader>ghR', gitsigns.reset_buffer)

        map('n', '<leader>ghb', function()
            gitsigns.blame_line({full = true})
        end)

        -- Toggles
        map('n', '<leader>gtb', gitsigns.toggle_current_line_blame)
        map('n', '<leader>gtw', gitsigns.toggle_word_diff)
    end
}