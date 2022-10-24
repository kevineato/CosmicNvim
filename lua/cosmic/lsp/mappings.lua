local M = {}

-- Mappings.
function M.init(client, bufnr)
    local buf_map = require("cosmic.utils").buf_map

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_map(bufnr, "n", "gd", function()
        require("telescope.builtin").lsp_definitions()
    end)
    buf_map(bufnr, "n", "gD", function()
        vim.lsp.buf.declaration()
    end)
    buf_map(bufnr, "n", "gi", function()
        require("telescope.builtin").lsp_implementations()
    end)
    buf_map(bufnr, "n", "gt", function()
        require("telescope.builtin").lsp_type_definitions()
    end)
    buf_map(bufnr, "n", "gr", function()
        require("telescope.builtin").lsp_references()
    end)
    buf_map(bufnr, "n", "gy", function()
        require("telescope.builtin").lsp_document_symbols({
            symbol_width = 50,
            symbol_type_width = 12,
        })
    end)
    buf_map(bufnr, "n", "gY", function()
        require("telescope.builtin").lsp_dynamic_workspace_symbols({
            symbol_width = 50,
            symbol_type_width = 12,
        })
    end)
    buf_map(bufnr, "n", "gn", function()
        require("cosmic-ui").rename()
    end)

    -- diagnostics
    buf_map(bufnr, "n", "[g", function()
        vim.diagnostic.goto_prev()
    end)
    buf_map(bufnr, "n", "]g", function()
        vim.diagnostic.goto_next()
    end)
    buf_map(bufnr, "n", "ge", function()
        vim.diagnostic.open_float({ scope = "line" })
    end)
    buf_map(bufnr, "n", "<Leader>ge", function()
        require("telescope.builtin").diagnostics({ bufnr = 0 })
    end)
    buf_map(bufnr, "n", "<Leader>gde", function()
        vim.diagnostic.enable()
    end)
    buf_map(bufnr, "n", "<Leader>gdd", function()
        vim.diagnostic.disable()
    end)

    -- hover
    buf_map(bufnr, "n", "K", function()
        vim.lsp.buf.hover()
    end)

    -- code actions
    buf_map(bufnr, "n", "<Leader>ga", function()
        require("cosmic-ui").code_actions()
    end)
    buf_map(bufnr, "v", "<Leader>ga", function()
        require("cosmic-ui").range_code_actions()
    end)

    -- formatting
    buf_map(bufnr, { "n", "v" }, "<Leader>gf", function()
        vim.lsp.buf.format({ async = true })
    end)

    -- signature help
    buf_map(bufnr, "n", "<Leader>K", function()
        require("lsp_signature").toggle_float_win()
    end)

    -- lsp workspace
    buf_map(bufnr, "n", "<Leader>gwa", function()
        vim.lsp.buf.add_workspace_folder()
    end)
    buf_map(bufnr, "n", "<Leader>gwr", function()
        vim.lsp.buf.remove_workspace_folder()
    end)
    buf_map(bufnr, "n", "<Leader>gwl", function()
        require("cosmic.utils.logger"):log(
            vim.inspect(vim.lsp.buf.list_workspace_folders())
        )
    end)

    if client.name == "tsserver" then
        -- typescript helpers
        buf_map(bufnr, "n", "<Leader>gr", "<Cmd>TSLspRenameFile<CR>")
        buf_map(bufnr, "n", "<Leader>go", "<Cmd>TSLspOrganize<CR>")
        buf_map(bufnr, "n", "<Leader>gi", "<Cmd>TSLspImportAll<CR>")
    end
end

return M
