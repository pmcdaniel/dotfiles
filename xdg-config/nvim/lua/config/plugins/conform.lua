require("conform").setup({
    formatters_by_ft = {
        c = { "clang_format" },
        cpp = { "clang_format" },
        css = { "prettierd" },
        lua = { "stylua" },
        markdown = { "prettierd" },
        sh = { "shfmt" },
        sql = { "sqlfluff" },
        yaml = { "prettierd" },
        zsh = { "shfmt" },
    },
    format_on_save = nil,
})
