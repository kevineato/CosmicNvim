local actions = require("telescope.actions")
local config = require("cosmic.core.user")
local icons = require("cosmic.theme.icons")
local u = require("cosmic.utils")

local function close_filetype_edit(func)
    local function decorated(prompt_bufnr)
        local api = vim.api

        local win_id = require("telescope.actions.state").get_current_picker(
            prompt_bufnr
        ).original_win_id
        local ft = vim.bo[api.nvim_win_get_buf(win_id)].filetype

        if ft == "neo-tree" or ft == "lir" then
            api.nvim_win_close(win_id, true)
        end

        func(prompt_bufnr)
    end

    return decorated
end

local default_mappings = {
    i = {
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-n>"] = actions.cycle_history_next,
        ["<M-q>"] = actions.smart_add_to_qflist + actions.open_qflist,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<M-a>"] = actions.toggle_all,
        ["<Tab>"] = actions.toggle_selection + actions.move_selection_next,
        ["<S-Tab>"] = actions.toggle_selection
            + actions.move_selection_previous,
        ["<C-x>"] = false,
        ["<C-v>"] = close_filetype_edit(
            actions.select_vertical + actions.center
        ),
        ["<C-s>"] = close_filetype_edit(
            actions.select_horizontal + actions.center
        ),
        ["<CR>"] = close_filetype_edit(actions.select_default + actions.center),
    },
    n = {
        ["Q"] = actions.smart_add_to_qflist + actions.open_qflist,
        ["q"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<M-a>"] = actions.toggle_all,
        ["<Tab>"] = actions.toggle_selection + actions.move_selection_next,
        ["<S-Tab>"] = actions.toggle_selection
            + actions.move_selection_previous,
        ["<Up>"] = actions.cycle_history_prev,
        ["<Down>"] = actions.cycle_history_next,
        ["<C-x>"] = false,
        ["<C-v>"] = close_filetype_edit(
            actions.select_vertical + actions.center
        ),
        ["<C-s>"] = close_filetype_edit(
            actions.select_horizontal + actions.center
        ),
        ["<CR>"] = close_filetype_edit(actions.select_default + actions.center),
    },
}

local telescope = require("telescope")
telescope.setup(u.merge({
    defaults = {
        mappings = default_mappings,
        sorting_strategy = "ascending",
        layout_strategy = "vertical",
        prompt_prefix = "🔍 ",
        selection_caret = icons.folder.arrow_closed,
        initial_mode = "normal",
        dynamic_preview_title = true,
        preview = { treesitter = false },
        layout_config = {
            cursor = {
                width = 0.6,
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
            mappings = u.merge(default_mappings, {
                i = {
                    ["<C-x>"] = actions.delete_buffer,
                },
                n = {
                    ["<C-x>"] = actions.delete_buffer,
                },
            }),
        },
        diagnostics = {
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
        },
        find_files = {
            prompt_title = "✨ Search Project ✨",
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

telescope.load_extension("fzf")
