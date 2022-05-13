require("nvim-lsp-installer").setup({})

local u = require("cosmic.utils")
local default_config = require("cosmic.lsp.providers.defaults")
local config = require("cosmic.core.user")
local lspconfig = require("lspconfig")

-- initial default servers
-- by default tsserver/ts_utils and null_ls are enabled
local requested_servers = {}

-- get disabled servers from config
local disabled_servers = {}
for config_server, config_opt in pairs(config.lsp.servers) do
    if config_opt == false then
        table.insert(disabled_servers, config_server)
    elseif not vim.tbl_contains(requested_servers, config_server) then
        -- add additonally defined servers to be installed
        table.insert(requested_servers, config_server)
    end
end

local function on_server_ready(server)
    local opts = default_config

    -- disable server if config disabled server list says so
    opts.autostart = true
    if vim.tbl_contains(disabled_servers, server.name) then
        opts.autostart = false
    end

    -- set up default cosmic options
    if server.name == "tsserver" then
        opts = u.merge(opts, require("cosmic.lsp.providers.tsserver"))
    elseif server.name == "jsonls" then
        opts = u.merge(opts, require("cosmic.lsp.providers.jsonls"))
    elseif server.name == "sumneko_lua" then
        opts = u.merge(opts, require("cosmic.lsp.providers.sumneko_lua"))
    end

    -- override options if user defines them
    if type(config.lsp.servers[server.name]) == "table" then
        if config.lsp.servers[server.name].opts ~= nil then
            if type(config.lsp.servers[server.name].opts) == "function" then
                opts = u.merge(
                    opts,
                    config.lsp.servers[server.name].opts(lspconfig)
                )
            else
                opts = u.merge(opts, config.lsp.servers[server.name].opts)
            end
        end
    end

    local lspconfig_server = lspconfig[server.name]
    if lspconfig_server then
        lspconfig_server.setup(opts)
        vim.cmd([[do User LspAttachBuffers]])
    end
end

-- go through requested_servers and ensure installation
local lsp_installer_servers = require("nvim-lsp-installer.servers")
for _, requested_server in pairs(requested_servers) do
    local ok, server = lsp_installer_servers.get_server(requested_server)
    if ok then
        if not server:is_installed() then
            server:install()
        end
        on_server_ready(server)
    end
end
