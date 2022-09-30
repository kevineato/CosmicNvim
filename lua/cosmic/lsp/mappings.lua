local M = {}

-- Mappings.
function M.init(client, bufnr)
    local buf_map = require("cosmic.utils").buf_map

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_map(
        bufnr,
        "n",
        "gd",
        '<Cmd>lua require("telescope.builtin").lsp_definitions()<CR>'
    )
    buf_map(bufnr, "n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>")
    buf_map(
        bufnr,
        "n",
        "gi",
        '<Cmd>lua require("telescope.builtin").lsp_implementations()<CR>'
    )
    buf_map(
        bufnr,
        "n",
        "gt",
        '<Cmd>lua require("telescope.builtin").lsp_type_definitions()<CR>'
    )
    buf_map(
        bufnr,
        "n",
        "gr",
        '<Cmd>lua require("telescope.builtin").lsp_references()<CR>'
    )
    buf_map(
        bufnr,
        "n",
        "gy",
        "<Cmd>lua require('telescope.builtin').lsp_document_symbols({ symbol_width = 50, symbol_type_width = 12 })<CR>"
    )
    buf_map(
        bufnr,
        "n",
        "gY",
        "<Cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols({ symbol_width = 50, symbol_type_width = 12 })<CR>"
    )
    buf_map(bufnr, "n", "gn", '<Cmd>lua require("cosmic-ui").rename()<CR>')

    -- diagnostics
    buf_map(bufnr, "n", "[g", "<Cmd>lua vim.diagnostic.goto_prev()<CR>")
    buf_map(bufnr, "n", "]g", "<Cmd>lua vim.diagnostic.goto_next()<CR>")
    buf_map(
        bufnr,
        "n",
        "ge",
        '<Cmd>lua vim.diagnostic.open_float({ scope = "line" })<CR>'
    )
    buf_map(
        bufnr,
        "n",
        "<Leader>ge",
        "<Cmd>lua require('telescope.builtin').diagnostics({ bufnr = 0 })<CR>"
    )
    buf_map(bufnr, "n", "<Leader>gde", "<Cmd>lua vim.diagnostic.enable()<CR>")
    buf_map(bufnr, "n", "<Leader>gdd", "<Cmd>lua vim.diagnostic.disable()<CR>")

    -- hover
    buf_map(bufnr, "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>")

    -- code actions
    buf_map(
        bufnr,
        "n",
        "<Leader>ga",
        '<Cmd>lua require("cosmic-ui").code_actions()<CR>'
    )
    buf_map(
        bufnr,
        "v",
        "<Leader>ga",
        ':lua require("cosmic-ui").range_code_actions()<CR>'
    )

    -- formatting
    buf_map(bufnr, "n", "<Leader>gf", "<Cmd>lua vim.lsp.buf.format({ async = true })<CR>")
    buf_map(bufnr, "v", "<Leader>gf", ":lua vim.lsp.buf.range_formatting()<CR>")

    -- signature help
    buf_map(
        bufnr,
        "n",
        "<Leader>K",
        '<Cmd>lua require("lsp_signature").toggle_float_win()<CR>'
    )

    -- lsp workspace
    buf_map(
        bufnr,
        "n",
        "<Leader>gwa",
        "<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>"
    )
    buf_map(
        bufnr,
        "n",
        "<Leader>gwr",
        "<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>"
    )
    buf_map(
        bufnr,
        "n",
        "<Leader>gwl",
        '<Cmd>lua require("cosmic.utils.logger"):log(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>'
    )

    if client.name == "tsserver" then
        -- typescript helpers
        buf_map(bufnr, "n", "<Leader>gr", "<Cmd>TSLspRenameFile<CR>")
        buf_map(bufnr, "n", "<Leader>go", "<Cmd>TSLspOrganize<CR>")
        buf_map(bufnr, "n", "<Leader>gi", "<Cmd>TSLspImportAll<CR>")
    end
end

return M
