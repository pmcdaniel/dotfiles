require('bufferline').setup({
    options = {
        diagnostics_indicator = function(_, _, diag)
            local icons = level:match('error') and " " or " "
            return " " .. icon .. count
        end,
    },
})
