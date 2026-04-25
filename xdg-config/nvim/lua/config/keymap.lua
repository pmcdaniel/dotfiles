-- Several keymaps that match Zed/VSCode
vim.keymap.set('n', '<leader>s', function()
    vim.cmd.write()
end, { desc = 'Save file' })
vim.keymap.set('n', '<leader>q', function()
    vim.cmd.quit()
end, { desc = 'Quit window' })
vim.keymap.set('n', '<leader>w', function()
    Snacks.bufdelete()
end, { desc = 'Close buffer' })

vim.keymap.set('n', '<leader>p', function()
    Snacks.picker.smart()
end, { desc = 'Smart Find Files' })
vim.keymap.set('n', '<leader>P', function()
    Snacks.picker.commands()
end, { desc = 'Command palette' })

vim.keymap.set('v', '<', '<gv', { desc = 'Indent left' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right' })

vim.keymap.set('n', '<leader>`', function()
    Snacks.terminal.toggle(nil, { win = { position = 'bottom', height = 0.35 } })
end, { desc = 'Toggle terminal' })

-- Make yanks go to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
