local group = vim.api.nvim_create_augroup('pmcdaniel_nvim', { clear = true })

vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufEnter', 'InsertLeave' }, {
    group = group,
    callback = function(args)
        local ok, lint = pcall(require, 'lint')
        if ok then
            lint.try_lint(nil, { ignore_errors = true })
        end
    end,
})

vim.api.nvim_create_autocmd('LspAttach', {
    group = group,
    desc = 'LSP defaults and keymaps',
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        local buffer = event.buf
        local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = buffer, desc = desc })
        end

        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
        end

        map('n', 'K', vim.lsp.buf.hover, "Hover")
        map('n', 'gD', vim.lsp.buf.declaration, 'Goto declaration')
        map('n', 'gd', function()
            Snacks.picker.lsp_definitions()
        end, "Goto Definition")
        map('n', 'gr', function()
            Snacks.picker.lsp_references()
        end, 'Goto references')
        map('n', 'gI', function()
            Snacks.picker.lsp_implementations()
        end, 'Goto implementation')
        map('n', 'gy', function()
            Snacks.picker.lsp_type_defintions()
        end, 'Goto type definition')
        map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, 'Code actions')
        map('n', '<leader>cr', vim.lsp.buf.rename, 'Rename symbol')
        map('n', '<leader>cs', function()
            Snacks.picker.lsp_symbols()
        end, 'Document symbols')
        map('n', '<leader>cS', function()
            Snacks.picker.lsp_workspace_symbols()
        end, 'Workspace symbols')
        map('n', '<leader>cd', function()
            Snacks.picker.diagnostics()
        end, 'Diagnostics')
        map('n', '<leader>cD', function()
            Snacks.picker.diagnostics_buffer()
        end, 'Buffer Diagnostics')
        map('n', '<leader>cf', function()
            require('conform').format({ bufnr = buffer, timeout_ms = 1000, lsp_format = 'fallback' })
        end, 'Format buffer')
        map('n', '[d', function()
            vim.diagnostics.goto_prev({ float = false })
        end, 'Previous diagnostic')
        map('n', ']d', function()
            vim.diagnostic.goto_next({ float = false })
        end, 'Next diagnostic')
        map("n", "[e", function()
            vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR, float = false })
        end, "Previous error")
        map("n", "]e", function()
            vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR, float = false })
        end, "Next error")
        map("n", "<leader>uh", function()
            local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = buffer })
            vim.lsp.inlay_hint.enable(not enabled, { bufnr = buffer })
        end, "Toggle inlay hints")

        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_group = vim.api.nvim_create_augroup('pmcdaniel_lsp_highlight_' .. buffer, { clear = true })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                group = highlight_group,
                buffer = buffer,
                callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI', 'LSPDetach' }, {
                group = highlight_group,
                buffer = buffer,
                callback = vim.lsp.buf.clear_references,
            })
        end
    end,
})

vim.diagnostic.config({
    virtual_text = true,
    float = {
        focusable = false,
        style = 'minimal',
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})
