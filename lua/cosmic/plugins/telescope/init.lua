local actions = require("telescope.actions")
local config = require("cosmic.core.user")
local icons = require("cosmic.theme.icons")
local u = require("cosmic.utils")

local function close_lir_edit(func)
    local function decorated(prompt_bufnr)
        local api = vim.api

        local win_id =
            require("telescope.state").get_status(prompt_bufnr).picker.original_win_id

        if vim.bo[api.nvim_win_get_buf(win_id)].filetype == "lir" then
            api.nvim_win_close(win_id, false)
        end

        func(prompt_bufnr)
    end

    return decorated
end

local default_mappings = {
    i = {
        ["<M-q>"] = actions.smart_add_to_qflist + actions.open_qflist,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<Tab>"] = actions.toggle_selection + actions.move_selection_next,
        ["<S-Tab>"] = actions.toggle_selection
            + actions.move_selection_previous,
        ["<C-v>"] = close_lir_edit(actions.select_vertical),
        ["<C-s>"] = close_lir_edit(actions.select_horizontal),
        ["<C-t>"] = close_lir_edit(actions.select_tab),
        ["<CR>"] = close_lir_edit(actions.select_default),
    },
    n = {
        ["Q"] = actions.smart_add_to_qflist + actions.open_qflist,
        ["q"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<Tab>"] = actions.toggle_selection + actions.move_selection_next,
        ["<S-Tab>"] = actions.toggle_selection
            + actions.move_selection_previous,
        ["v"] = close_lir_edit(actions.select_vertical),
        ["s"] = close_lir_edit(actions.select_horizontal),
        ["t"] = close_lir_edit(actions.select_tab),
        ["<CR>"] = close_lir_edit(actions.select_default),
    },
}

local opts_cursor = {
    sorting_strategy = "ascending",
    layout_strategy = "cursor",
    results_title = false,
    layout_config = {
        width = 0.6,
        height = 0.4,
    },
}

require("telescope").setup(u.merge({
    defaults = {
        mappings = default_mappings,
        layout_strategy = "vertical",
        prompt_prefix = "🔍 ",
        selection_caret = icons.folder.arrow_closed,
        dynamic_preview_title = true,
        preview = { treesitter = false },
        layout_config = {
            cursor = {
                width = 0.5,
                height = 0.4,
            },
        },
        vimgrep_arguments = {
            "rg",
            "--no-ignore",
            "--hidden",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--trim",
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
    },
    pickers = {
        buffers = {
            prompt_title = "✨ Search Buffers ✨",
            mappings = u.merge({
                n = {
                    ["d"] = actions.delete_buffer,
                },
            }, default_mappings),
        },
        lsp_code_actions = u.merge(opts_cursor, {
            prompt_title = "Code Actions",
        }),
        lsp_range_code_actions = {
            prompt_title = "Code Actions",
        },
        lsp_document_diagnostics = {
            prompt_title = "Document Diagnostics",
        },
        lsp_implementations = {
            prompt_title = "Implementations",
        },
        lsp_definitions = {
            prompt_title = "Definitions",
        },
        lsp_references = {
            prompt_title = "References",
            mappings = default_mappings,
        },
        find_files = {
            prompt_title = "✨ Search Project ✨",
            no_ignore = true,
            hidden = true,
            follow = true,
        },
        git_files = {
            prompt_title = "✨ Search Git Project ✨",
            hidden = true,
        },
        live_grep = {
            prompt_title = "✨ Live Grep ✨",
        },
        grep_string = {
            prompt_title = "✨ Grep String ✨",
        },
    },
}, config.telescope or {}))

require("telescope").load_extension("fzf")
