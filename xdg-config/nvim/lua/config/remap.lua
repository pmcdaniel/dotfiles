vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Make paste not delete it out of clipboard
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Make yanks go to system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Format source file using Conform plugin
vim.keymap.set("n", "<leader>f", function()
    require("conform").format({ bufnr = 0 })
end)
