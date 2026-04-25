local Snacks = require('snacks')

Snacks.setup({
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = {
        enabled = true,
        replace_netrw = true,
        trash = false,
    },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = {
        enabled = true,
        timeout = 3000,
    },
    picker = {
        enabled = true,
        ui_select = true,
        layout = {
            present = 'vscode',
        },
        sources = {
            files = {
                hidden = true,
                ignored = true,
            },
            grep = {
                hidden = true,
                ignored = true,
            },
            explorer = {
                auto_close = true,
                follow_file = true,
            },
        },
    },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = false },
    words = { enabled = true },
})

Snacks.input.enable()
vim.schedule(function()
    vim.ui.select = Snacks.picker.select
end)
