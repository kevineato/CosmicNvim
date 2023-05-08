local config = require("cosmic.core.user")
local u = require("cosmic.utils")

local defaults = {
    pre_save_cmds = {
        "cclose",
        "lua vim.notify.dismiss()",
    },
    auto_session_enabled = false,
    auto_save_enabled = true,
    auto_restore_enabled = false,
    session_lens = {},
}

if vim.fn.exists(":Neotree") > 0 then
    table.insert(defaults.pre_save_cmds, "Neotree close")
end

if vim.fn.exists(":NvimTreeClose") > 0 then
    table.insert(defaults.pre_save_cmds, "NvimTreeClose")
end

require("auto-session").setup(u.merge(defaults, config.auto_session or {}))
require("telescope").load_extension("session-lens")
require("cosmic.plugins.auto-session.mappings")
