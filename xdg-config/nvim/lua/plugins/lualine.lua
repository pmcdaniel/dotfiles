return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-mini/mini.icons", version = "*" },
        event = "VeryLazy",
        config = function()
            require("mini.icons").setup()
            require("mini.icons").mock_nvim_web_devicons()
            require("lualine").setup {
                options = { theme = "gruvbox" }
            }
        end,
    },
}
