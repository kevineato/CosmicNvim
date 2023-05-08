local cmp = require("cmp")
local u = require("cosmic.utils")
local user_config = require("cosmic.core.user")
local icons = require("cosmic.theme.icons")

local default_cmp_opts = {
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
        end,
    },
    mapping = {
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            require("cmp_nvim_ultisnips.mappings").expand_or_jump_forwards(
                fallback
            )
        end, {
            "i",
            "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            require("cmp_nvim_ultisnips.mappings").jump_backwards(fallback)
        end, {
            "i",
            "s",
        }),
    },
    window = {
        completion = {
            border = user_config.border,
        },
        documentation = {
            border = user_config.border,
            winhighlight = "FloatBorder:FloatBorder,Normal:Normal",
        },
    },
    experimental = {
        ghost_text = { hl_group = "Comment" },
    },
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "ultisnips" },
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
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
        { name = "buffer" },
    }),
})
