local config = require("cosmic.core.user")
local ls = require("luasnip")
local types = require("luasnip.util.types")
local u = require("cosmic.utils")

-- some shorthands...
--[[ local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node ]]

-- Every unspecified option will be set to the default.
ls.config.set_config(u.merge({
    history = true,
    -- Update more often, :h events for more info.
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { "●", "GruvboxOrange" } },
            },
        },
        [types.insertNode] = {
            active = {
                virt_text = { { "●", "GruvboxBlue" } },
            },
        },
    },
}, config.luasnip or {}))

u.snippets_clear()

local config_path = vim.fn.resolve(vim.fn.stdpath("config") .. "/lua/snippets")

vim.cmd([[
    augroup snippets_reload
        au!
        au BufWritePost ]] .. config_path .. [[/*.lua lua require('cosmic.utils').snippets_clear()
        au BufWritePost ]] .. config_path .. [[/*.json lua require('cosmic.utils').snippets_clear()
    augroup end
]])

vim.api.nvim_add_user_command(
    "LuaSnipEdit",
    require("cosmic.utils").edit_snippets_ft,
    {}
)
