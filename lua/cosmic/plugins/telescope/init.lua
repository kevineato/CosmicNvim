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
local telescope_setup_opts = u.merge({
    defaults = {
        tiebreak = function(current_entry, existing_entry, _)
            return current_entry.ordinal < existing_entry.ordinal
        end,
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
            override_file_sorter = true,
            override_generic_sorter = true,
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
        oldfiles = {
            -- Don't break ties with fzf so it doesn't break MRU sort.
            tiebreak = function()
                return false
            end,
        },
    },
}, config.telescope or {})

telescope.setup(telescope_setup_opts)

-- Wrap scoring function to return 0 on score of 1 (empty prompt), which allows
-- tiebreak to run for fzf.
local exports = telescope.load_extension("fzf")

local telescope_config = require("telescope.config")
local alt_sorter = function(opts)
    local options = {}
    options.case_mode = vim.F.if_nil(
        opts.case_mode,
        telescope_setup_opts.extensions.fzf.case_mode
    )
    options.fuzzy =
        vim.F.if_nil(opts.fuzzy, telescope_setup_opts.extensions.fzf.fuzzy)
    local og_scoring_function =
        exports.native_fzf_sorter(options).scoring_function
    local sorter = exports.native_fzf_sorter(options)
    sorter.scoring_function = function(self, prompt, line)
        local score = og_scoring_function(self, prompt, line)
        return score == 1 and 0 or score
    end
    return sorter
end

if telescope_setup_opts.extensions.fzf.override_file_sorter then
    telescope_config.values.file_sorter = alt_sorter
end
if telescope_setup_opts.extensions.fzf.override_generic_sorter then
    telescope_config.values.generic_sorter = alt_sorter
end
