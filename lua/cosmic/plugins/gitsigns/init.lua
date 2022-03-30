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
    keymaps = {
        -- Default keymap options
        noremap = true,

        ["n ]c"] = {
            expr = true,
            "&diff ? ']c' : '<Cmd>Gitsigns next_hunk<CR>'",
        },
        ["n [c"] = {
            expr = true,
            "&diff ? '[c' : '<Cmd>Gitsigns prev_hunk<CR>'",
        },

        ["n <Leader>hs"] = "<Cmd>Gitsigns stage_hunk<CR>",
        ["v <Leader>hs"] = ":Gitsigns stage_hunk<CR>",
        ["n <Leader>hu"] = "<Cmd>Gitsigns undo_stage_hunk<CR>",
        ["n <Leader>hr"] = "<Cmd>Gitsigns reset_hunk<CR>",
        ["v <Leader>hr"] = ":Gitsigns reset_hunk<CR>",
        ["n <Leader>hR"] = "<Cmd>Gitsigns reset_buffer<CR>",
        ["n <Leader>hp"] = "<Cmd>Gitsigns preview_hunk<CR>",
        ["n <Leader>hb"] = "<Cmd>lua require('gitsigns').blame_line{full=true}<CR>",
        ["n <Leader>hS"] = "<Cmd>Gitsigns stage_buffer<CR>",
        ["n <Leader>hU"] = "<Cmd>Gitsigns reset_buffer_index<CR>",

        -- Text objects
        ["o ih"] = ":<C-U>Gitsigns select_hunk<CR>",
        ["x ih"] = ":<C-U>Gitsigns select_hunk<CR>",
    },
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
