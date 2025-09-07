return {
    'saghen/blink.cmp',
    dependencies = { 'L3MON4D3/LuaSnip', version = 'v2.*' },
    version = '1.*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = { preset = 'enter' },
        appearance = { nerd_font_variant = 'mono' },
        completion = {
            documentation = { auto_show = false },
            menu = {
                draw = {
                    components = {
                        kind_icon = {
                            text = function(ctx)
                                local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                                return kind_icon
                            end,

                            highlight = function(ctx)
                                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                                return hl
                            end,
                        },
                        kind = {
                            highlight = function(ctx)
                                local _, hl, _ = require("mini.icons"),get("lsp", ctx.kind)
                                return hl
                            end,
                        }
                    }
                }
            }
        },
        snippets = { preset = 'luasnip' },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default"}
}
