local config = require("cosmic.core.user")
local u = require("cosmic.utils")

require("mason").setup(config.mason or {})
require("mason-lspconfig").setup(u.merge({
    automatic_installation = true,
}, config.mason_lspconfig or {}))

local default_config = require("cosmic.lsp.providers.defaults")
local lspconfig = require("lspconfig")
local registry = require("mason-registry")

for config_client, _ in pairs(config.lsp.clients) do
    local ok, package = pcall(registry.get_package, config_client)
    if ok and not package:is_installed() then
        vim.schedule(function()
            vim.notify("Installing " .. config_client)
        end)
        package:install()
    end
end

for config_server, config_opt in pairs(config.lsp.servers) do
    local opts = default_config

    -- disable server if config disabled server list says so
    opts.autostart = true
    if config_opt == false then
        opts.autostart = false
    end

    -- set up default cosmic options
    if config_server == "tsserver" then
        opts = u.merge(opts, require("cosmic.lsp.providers.tsserver"))
    elseif config_server == "jsonls" then
        opts = u.merge(opts, require("cosmic.lsp.providers.jsonls"))
    elseif config_server == "lua_ls" then
        opts = u.merge(opts, require("cosmic.lsp.providers.lua_ls"))
    end

    -- override options if user defines them
    if type(config.lsp.servers[config_server]) == "table" then
        if config.lsp.servers[config_server].opts ~= nil then
            if type(config.lsp.servers[config_server].opts) == "function" then
                opts = u.merge(
                    opts,
                    config.lsp.servers[config_server].opts(lspconfig)
                )
            else
                opts = u.merge(opts, config.lsp.servers[config_server].opts)
            end
        end
    end

    local lspconfig_server = lspconfig[config_server]
    if lspconfig_server then
        lspconfig_server.setup(opts)
        vim.cmd([[do User LspAttachBuffers]])
    end
end
