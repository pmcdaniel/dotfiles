return {
    'stevearc/conform.nvim',
    opts = {},
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
                go = { "gofmt" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                cpp = { "clang_format" },
                c = { "clang_format" },
            }
        })
    end
}
