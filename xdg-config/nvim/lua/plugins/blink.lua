return {
    'saghen/blink.cmp',
    version = '1.*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        enabled = function ()
            return not vim.tbl_contains({"gitcommit", "markdown"}, vim.bo.filetype)
        end,
        keymap = { preset = 'super-tab' },
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
                                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                                return hl
                            end,
                        }
                    }
                }
            },
        },
        sources = {
            default = function(ctx)
                local success, node = pcall(vim.treesitter.get_node)
                if success and node and vim.tbl_contains({"comment", "line_comment", "block_comment" }, node:type()) then
                    return { "buffer" }
                else
                    return { 'lsp', 'path', 'snippets', 'buffer' }
                end
            end
        },
        fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default"}
}
