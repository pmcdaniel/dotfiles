return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        lazy = false,
        opts = {
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
            ensure_installed = {
                'bash',
                'c',
                'cmake',
                'cpp',
                'css',
                'csv',
                'diff',
                'dockerfile',
                'editorconfig',
                'git_config',
                'git_rebase',
                'gitattributes',
                'gitcommit',
                'gitignore',
                'go',
                'gomod',
                'gosum',
                'gowork',
                'helm',
                'html',
                'java',
                'javadoc',
                'javascript',
                'jsdoc',
                'json',
                'jsonc',
                'lua',
                'luadoc',
                'luap',
                'markdown',
                'markdown_inline',
                'mermaid',
                'nginx',
                'printf',
                'python',
                'regex',
                'sql',
                'ssh_config',
                'swift',
                'toml',
                'tsx',
                'typescript',
                'vim',
                'vimdoc',
                'xml',
                'yaml',
            },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        after = "nvim-treesitter",
        config = function()
            require('treesitter-context').setup {
                enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
                multiwindow = false,      -- Enable multiwindow support.
                max_lines = 0,            -- How many lines the window should span. Values <=0 mean no limit.
                min_window_height = 0,    -- Minimum editor height to enable context. Values <= 0 mean no limit.
                line_numbers = true,
                multiline_threshold = 20, -- Maximum number of lines to show for a single context
                trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
                mode = 'cursor',          -- Line used to calculate context.  Choies: 'cursor', 'topline'
                -- Separator between context and content.  Should be a single character string, line '-'.
                -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
                separator = nil,
                zindex = 20,     -- The Z-index of the context window
                on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
            }
        end
    }
}
