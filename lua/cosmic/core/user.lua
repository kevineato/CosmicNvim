-- DO NOT TOUCH :)
local ok, user_config = pcall(require, "cosmic.config.config")

if not ok then
    user_config = {}
end

-- these settings will be merged with any settings definined in config.lua
local default_config = {
    mapleader = { as_string = " ", as_code = "<Space>" },
    border = "rounded",
    disable_builtin_plugins = {},
    add_plugins = {},
    theme = "tokyonight",
    lsp = {
        format_on_save = true, -- true/false or table of filetypes {'.ts', '.js',}
        rename_notification = true,
        -- vim.diagnostic.config settings
        clients = {},
        servers = {
            -- enable/disable server + formatting
            -- enable non-default servers
            -- rust_analyzer = true,

            -- or override lsp server options
            -- rust_analyzer = {
            --     opts = {},
            -- },

            jsonls = {
                format = false,
            },
            lua_ls = {
                format = false, -- disable formatting all together
            },
            html = true,
            tsserver = {
                format = false, -- disable formatting all together
            },
        },
    },
}

local u = require("cosmic.utils")
local config = u.merge(default_config, user_config)
local user_clients = vim.tbl_keys(config.lsp.clients)
local user_servers = vim.tbl_keys(config.lsp.servers)

function config.lsp.can_client_format(client_name)
    if config.lsp.clients[client_name] == true then
        return true
    end

    if config.lsp.servers[client_name] == true then
        return true
    end

    if
        vim.tbl_contains(user_clients, client_name)
        and config.lsp.clients[client_name]
    then
        return (config.lsp.clients[client_name].format == true)
    end

    if
        vim.tbl_contains(user_servers, client_name)
        and config.lsp.servers[client_name]
    then
        return (config.lsp.servers[client_name].format == true)
    end

    return true
end

return config
