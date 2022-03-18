local cmp = require("cmp")
local u = require("cosmic.utils")
-- local luasnip = require("luasnip")
local user_config = require("cosmic.core.user")
local icons = require("cosmic.theme.icons")
local map = require("cosmic.utils").map

-- local function has_words_before()
--     local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--     return col ~= 0
--         and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
--                 :sub(col, col)
--                 :match("%s")
--             == nil
-- end
--
-- local function t(keys)
--     vim.api.nvim_feedkeys(
--         vim.api.nvim_replace_termcodes(keys, true, true, true),
--         "m",
--         true
--     )
-- end

map(
    "i",
    "<Plug>(cmp-ulti-expand)",
    "<C-r>=[UltiSnips#CursorMoved(), UltiSnips#ExpandSnippet()][1]<CR>",
    { noremap = false }
)
map(
    "s",
    "<Plug>(cmp-ulti-expand)",
    "<Esc>:call UltiSnips#ExpandSnippetOrJump()<CR>",
    { noremap = false }
)
map(
    "i",
    "<Plug>(cmp-ulti-jump-forwards)",
    "<C-r>=UltiSnips#JumpForwards()<CR>",
    { noremap = false }
)
map(
    "s",
    "<Plug>(cmp-ulti-jump-forwards)",
    "<Esc>:call UltiSnips#JumpForwards()<CR>",
    { noremap = false }
)
map(
    "i",
    "<Plug>(cmp-ulti-jump-backwards)",
    "<C-r>=UltiSnips#JumpBackwards()<CR>",
    { noremap = false }
)
map(
    "s",
    "<Plug>(cmp-ulti-jump-backwards)",
    "<Esc>:call UltiSnips#JumpBackwards()<CR>",
    { noremap = false }
)

local default_cmp_opts = {
    snippet = {
        expand = function(args)
            -- luasnip.lsp_expand(args.body)
            vim.fn["UltiSnips#Anon"](args.body)
        end,
    },
    mapping = {
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        -- disabled for autopairs mapping
        -- ["<CR>"] = cmp.mapping(function(fallback)
        --     if luasnip.choice_active() and luasnip.jumpable(1) then
        --         luasnip.jump(1)
        --     elseif
        --         not cmp.confirm({
        --             behavior = cmp.ConfirmBehavior.Replace,
        --             select = false,
        --         })
        --     then
        --         fallback()
        --     end
        -- end),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        }),
        -- ["<Tab>"] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --         cmp.select_next_item()
        --     elseif luasnip.choice_active() then
        --         luasnip.change_choice(1)
        --     elseif luasnip.expand_or_jumpable() then
        --         luasnip.expand_or_jump()
        --     elseif has_words_before() then
        --         cmp.complete()
        --     else
        --         fallback()
        --     end
        -- end, {
        --     "i",
        --     "s",
        -- }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            require("cmp_nvim_ultisnips.mappings").expand_or_jump_forwards(fallback)
        end, {
            "i",
            "s",
        }),
        -- ["<S-Tab>"] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --         cmp.select_prev_item()
        --     elseif luasnip.choice_active() then
        --         luasnip.change_choice(1)
        --     elseif luasnip.jumpable(-1) then
        --         luasnip.jump(-1)
        --     else
        --         fallback()
        --     end
        -- end, {
        --     "i",
        --     "s",
        -- }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            require("cmp_nvim_ultisnips.mappings").jump_backwards(fallback)
        end, {
            "i",
            "s",
        }),
    },
    documentation = {
        border = user_config.border,
        winhighlight = "FloatBorder:FloatBorder,Normal:Normal",
    },
    experimental = {
        ghost_text = true,
    },
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "ultisnips" },
        -- { name = "luasnip" },
        { name = "nvim_lua" },
        { name = "path" },
    }, {
        { name = "buffer" },
    }),
    formatting = {
        format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format(
                "%s %s",
                icons.kind_icons[vim_item.kind],
                vim_item.kind
            )
            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                ultisnips = "[UltiSnips]",
                -- luasnip = "[LuaSnip]",
                buffer = "[Buffer]",
                path = "[Path]",
                nvim_lua = "[Lua]",
                cmdline = "[Cmd]",
            })[entry.source.name]
            return vim_item
        end,
    },
}

vim.cmd([[
    autocmd FileType TelescopePrompt lua require('cmp').setup.buffer { enabled = false }
]])

local opts = u.merge(default_cmp_opts, user_config.nvim_cmp or {})

cmp.setup(opts)

cmp.setup.cmdline("/", {
    sources = {
        { name = "buffer" },
    },
})

cmp.setup.cmdline(":", {
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
        { name = "buffer" },
    }),
})
