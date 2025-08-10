return {
    'stevearc/conform.nvim',
    opts = {},
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "isort", "black" },
                go = { "gofmt" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                cpp = { "clang_format" },
                c = { "clang_format" },
            }
        })
    end
}
