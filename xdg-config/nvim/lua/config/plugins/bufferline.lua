require('bufferline').setup({
    options = {
        diagnostics_indicator = function(count, level, _, _)
            local icon = level:match('error') and " " or " "
            return " " .. icon .. count
        end,
    },
})
