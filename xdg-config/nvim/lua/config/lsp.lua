local M = {}

local uv = vim.uv or vim.loop

local function has(bin)
    return vim.fn.exepath(bin) ~= ''
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, blink = pcall(require, 'blink.cmp')
if ok then
    capabilities = blink.get_lsp_capabilities(capabilities)
end

local function with_capabilities(config)
    return vim.tbl_deep_extend('force', {
        capabilities = vim.deepcopy(capabilities),
    }, config or {})
end

local function enable(server)
    vim.lsp.enable(server)
end

local function preferred_python_server()
    if has('ty') then
        return 'ty'
    end

    if has('basedpyright') or has('basedpyright-langserver') then
        return 'basedpyright'
    end

    return nil
end

M.servers = {
    bashls = {},
    clangd = {},
    dockerls = {},
    gopls = {
        filetypes = { 'go', 'gomod' },
        settings = {
            gopls = {
                analyses = {
                    shadow = true,
                    unusedparams = true,
                },
                gofumpt = true,
            },
        },
    },
    html = {},
    jsonls = {
        settings = {
            json = {
                format = { enable = true },
                validate = { enable = true },
            },
        },
    },
    lua_ls = {
        on_init = function(client)
            if client.workspace_folders then
                local path = client.workspace_folders[1].name
                if path ~= vim.fn.stdpath('config') and (uv.fs_stat(path .. '/.luarc.json') or uv.fs_stat(path .. '/.luarc.jsonc'))
                then
                    return
                end
            end

            client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                runtime = {
                    version = 'LuaJIT',
                },
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME,
                    },
                },
            })
        end,
        settings = {
            Lua = {
                completion = {
                    callSnippet = "Replace",
                },
                hint = {
                    enable = true,
                    arrayIndex = 'Enable',
                    await = true,
                    paramName = 'All',
                    paramType = true,
                    semicolon = 'Disable',
                    setType = true,
                },
            },
        },
    },
    marksman = {
        filetypes = { 'markdown' },
    },
    oxlint = {
        settings = {
            fixKind = 'safe_fix',
        },
    },
    basedpyright = {
        settings = {
            basedpyright = {
                analysis = { typeCheckingMode = 'standard', },
            },
        },
    },
    ruff = {},
    sqls = {},
    tailwindcss = {
        filetypes = { 'html', 'css', 'javascriptreact', 'typescriptreact' },
    },
    terraformls = {
        filetypes = { 'terraform' },
        init_options = {
            experimentalFeatures = {
                prefillRequiredFields = true,
            },
        },
    },
    tflint = {},
    ty = {},
    vtsls = {
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        settings = {
            javascript = {
                inlayHints = {
                    enumMemberValues = { enabled = true },
                    functionLikeReturnTypes = { enabled = true },
                    parameterNames = {
                        enabled = "all",
                        suppressWhenArgumentMatchesName = false,
                    },
                    parameterTypes = { enabled = true },
                    propertyDeclarationTypes = { enabled = true },
                    variableTypes = {
                        enabled = true,
                        suppressWhenTypeMatchesName = true,
                    },
                },
                tsserver = {
                    maxTsServerMemory = 16184,
                },
            },
            typescript = {
                inlayHints = {
                    enumMemberValues = { enabled = true },
                    functionLikeReturnTypes = { enabled = true },
                    parameterNames = {
                        enabled = "all",
                        suppressWhenArgumentMatchesName = false,
                    },
                    parameterTypes = { enabled = true },
                    propertyDeclarationTypes = { enabled = true },
                    variableTypes = {
                        enabled = true,
                        suppressWhenTypeMatchesName = true,
                    },
                },
                tsserver = {
                    maxTsServerMemory = 16184,
                },
            },
        },
    },
    yamlls = {
        filetypes = { 'yaml' },
        settings = {
            yaml = {
                format = {
                    enable = true,
                    singleQuote = true,
                },
                keyOrdering = false,
                validate = true,
            },
        },
    },
}

M.mason_servers = {
    'bashls',
    'clangd',
    'dockerls',
    'gopls',
    'html',
    'jsonls',
    'lua_ls',
    'marksman',
    'oxlint',
    'basedpyright',
    'ruff',
    'sqls',
    'tailwindcss',
    'terraformls',
    'tflint',
    'ty',
    'vtsls',
    'yamlls',
}

function M.setup()
    for server, config in pairs(M.servers) do
        vim.lsp.config(server, with_capabilities(config))
    end

    for _, server in ipairs({
        'bashls',
        'clangd',
        'dockerls',
        'gopls',
        'html',
        'jsonls',
        'lua_ls',
        'marksman',
        'ruff',
        'sqls',
        'tailwindcss',
        'terraformls',
        'tflint',
        'vtsls',
        'yamlls',
    }) do
        enable(server)
    end

    local python_server = preferred_python_server()
    if python_server then
        enable(python_server)
    end

    if has('oxlint') then
        enable('oxlint')
    end
end

return M
