local u = require("cosmic.utils")
local icons = require("cosmic.theme.icons")
local config = require("cosmic.core.user")

-- set up LSP signs
local signs = {
    Error = icons.error .. " ",
    Warn = icons.warn .. " ",
    Hint = icons.hint .. " ",
    Info = icons.info .. " ",
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- set up vim.diagnostics
-- vim.diagnostic.config opts
vim.diagnostic.config(u.merge({
    underline = true,
    signs = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = config.border,
        header = { icons.debug .. " Diagnostics:", "Normal" },
        source = false,
        prefix = function(diagnostic, i, total)
            local index_str = total > 1 and tostring(i) .. ". " or ""
            local code_str = ""
            if diagnostic.code then
                code_str = "[" .. diagnostic.code .. "]"
            elseif
                diagnostic.user_data
                and diagnostic.user_data.lsp
                and diagnostic.user_data.lsp.code
            then
                code_str = "[" .. diagnostic.user_data.lsp.code .. "]"
            end
            return index_str
                .. (diagnostic.source or "")
                .. (string.len(code_str) > 0 and code_str .. ": " or "")
        end,
    },
    virtual_text = {
        spacing = 1,
        source = true,
        severity = {
            min = vim.diagnostic.severity.HINT,
        },
    },
}, config.diagnostic or {}))
