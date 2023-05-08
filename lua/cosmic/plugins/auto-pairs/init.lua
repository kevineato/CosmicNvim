local npairs = require("nvim-autopairs")
local cond = require("nvim-autopairs.conds")
local Rule = require("nvim-autopairs.rule")

npairs.setup({
    check_ts = false,
    fast_wrap = {},
})

npairs.add_rules({
    Rule("<", ">", { "cpp", "h", "hpp" })
        :with_pair(cond.before_regex("[%w_]"))
        :with_pair(cond.not_add_quote_inside_quote())
        :with_move(function(opts)
            if opts.next_char == opts.char then
                return true
            end
            return false
        end),
    Rule(" ", " "):with_pair(function(opts)
        local pair = opts.line:sub(opts.col - 1, opts.col)
        return vim.tbl_contains({ "()", "[]", "{}", "<>" }, pair)
    end),
    Rule("< ", " >", { "cpp", "h", "hpp" })
        :with_pair(function()
            return false
        end)
        :with_move(function(opts)
            return opts.prev_char:match(".%>") ~= nil
        end)
        :use_key(">"),
    Rule("( ", " )")
        :with_pair(function()
            return false
        end)
        :with_move(function(opts)
            return opts.prev_char:match(".%)") ~= nil
        end)
        :use_key(")"),
    Rule("{ ", " }")
        :with_pair(function()
            return false
        end)
        :with_move(function(opts)
            return opts.prev_char:match(".%}") ~= nil
        end)
        :use_key("}"),
    Rule("[ ", " ]")
        :with_pair(function()
            return false
        end)
        :with_move(function(opts)
            return opts.prev_char:match(".%]") ~= nil
        end)
        :use_key("]"),
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on(
    "confirm_done",
    cmp_autopairs.on_confirm_done()
)
