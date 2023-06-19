local config = require("cosmic.core.user")
local u = require("cosmic.utils")

require("gitsigns").setup(u.merge({
    signs = {
        add = {
            hl = "GitSignsAdd",
            text = "│",
            numhl = "GitSignsAddNr",
            linehl = "GitSignsAddLn",
        },
        change = {
            hl = "GitSignsChange",
            text = "│",
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn",
        },
        delete = {
            hl = "GitSignsDelete",
            text = "_",
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn",
        },
        topdelete = {
            hl = "GitSignsDelete",
            text = "‾",
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn",
        },
        changedelete = {
            hl = "GitSignsChange",
            text = "~",
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn",
        },
    },
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    on_attach = function(bufnr)
        local gitsigns = require("gitsigns")
        local opts = { buffer = bufnr }

        vim.keymap.set("n", "]c", function()
            return vim.o.diff and "]c"
                or "<Cmd>lua require('gitsigns').next_hunk()<CR>"
        end, u.merge(opts, { expr = true }))
        vim.keymap.set("n", "[c", function()
            return vim.o.diff and "[c"
                or "<Cmd>lua require('gitsigns').prev_hunk()<CR>"
        end, u.merge(opts, { expr = true }))
        vim.keymap.set("n", "<Leader>hs", gitsigns.stage_hunk, opts)
        vim.keymap.set("v", "<Leader>hs", function()
            gitsigns.stage_hunk({ vim.fn.line("v"), vim.fn.line(".") })
        end, opts)
        vim.keymap.set("n", "<Leader>hu", gitsigns.undo_stage_hunk, opts)
        vim.keymap.set("n", "<Leader>hr", gitsigns.reset_hunk, opts)
        vim.keymap.set("v", "<Leader>hr", function()
            gitsigns.reset_hunk({ vim.fn.line("v"), vim.fn.line(".") })
        end, opts)
        vim.keymap.set("n", "<Leader>hR", gitsigns.reset_buffer, opts)
        vim.keymap.set("n", "<Leader>hp", gitsigns.preview_hunk, opts)
        vim.keymap.set("n", "<Leader>hb", function()
            gitsigns.blame_line({ full = true })
        end, opts)
        vim.keymap.set("n", "<Leader>hS", gitsigns.stage_buffer, opts)
        vim.keymap.set("n", "<Leader>hU", gitsigns.reset_buffer_index, opts)
        vim.keymap.set({ "o", "x" }, "ih", gitsigns.select_hunk, opts)
    end,
    watch_gitdir = {
        interval = 1000,
        follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
    },
    current_line_blame_formatter_opts = {
        relative_time = false,
    },
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000,
    preview_config = {
        -- Options passed to nvim_open_win
        border = config.border,
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
    },
    yadm = {
        enable = false,
    },
}, config.gitsigns or {}))
