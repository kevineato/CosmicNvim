local neotree = require("neo-tree")
local u = require("cosmic.utils")
local user_config = require("cosmic.core.user")

vim.g.neo_tree_remove_legacy_commands = true

neotree.setup(u.merge({
    source_selector = {
        winbar = true,
    },
    close_if_last_window = false,
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = false,
    default_component_configs = {
        indent = {
            indent_size = 2,
            padding = 0,
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
            with_expanders = false,
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
        },
        icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "",
            default = "",
        },
        name = {
            trailing_slash = false,
            use_git_status_colors = true,
        },
        git_status = {
            symbols = {
                added = "",
                deleted = "",
                modified = "",
                renamed = "➜",
                untracked = "★",
                ignored = "◌",
                unstaged = "✗",
                staged = "✓",
                conflict = "",
            },
        },
    },
    window = {
        position = "left",
        width = 40,
        mappings = {
            ["<2-LeftMouse>"] = "open",
            ["<CR>"] = "open",
            ["o"] = "open",
            ["S"] = "open_split",
            ["s"] = "open_vsplit",
            ["w"] = "open_with_window_picker",
            ["C"] = "close_node",
            ["z"] = "close_all_nodes",
            ["R"] = "refresh",
            ["a"] = "add",
            ["A"] = "add_directory",
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy",
            ["m"] = "move",
            ["q"] = "close_window",
            ["I"] = { "toggle_preview", config = { use_float = true } },
            ["P"] = function(state)
                local api = vim.api
                if state.tree then
                    local node = state.tree:get_node()
                    if node then
                        local parent_id = node:get_parent_id()
                        if parent_id then
                            local _, linenr = state.tree:get_node(parent_id)
                            local col = api.nvim_win_get_cursor(0)[2]
                            api.nvim_win_set_cursor(0, { linenr, col })
                        end
                    end
                end
            end,
        },
    },
    nesting_rules = {},
    filesystem = {
        bind_to_cwd = true,
        cwd_target = {
            sidebar = "window",
            current = "window",
        },
        find_by_full_path_words = true,
        follow_current_file = { enabled = true },
        hijack_netrw_behavior = "open_default",
        use_libuv_file_watcher = true,
        filtered_items = {
            visible = false,
            hide_dotfiles = false,
            hide_gitignored = false,
        },
        window = {
            mappings = {
                ["-"] = "navigate_up",
                ["."] = "set_root",
                ["H"] = "toggle_hidden",
                ["/"] = "fuzzy_finder",
                ["f"] = "filter_on_submit",
                ["<C-x>"] = "clear_filter",
            },
            fuzzy_finder_mappings = {
                ["<C-j>"] = "move_cursor_down",
                ["<C-k>"] = "move_cursor_up",
            },
        },
    },
    buffers = {
        bind_to_cwd = true,
        show_unloaded = true,
        window = {
            mappings = {
                ["bx"] = "buffer_delete",
                ["-"] = "navigate_up",
                ["."] = "set_root",
            },
        },
    },
    git_status = {
        window = {
            position = "float",
            mappings = {
                ["A"] = "git_add_all",
                ["gu"] = "git_unstage_file",
                ["ga"] = "git_add_file",
                ["gr"] = "git_revert_file",
                ["gc"] = "git_commit",
                ["gp"] = "git_push",
                ["gg"] = "git_commit_and_push",
            },
        },
    },
    event_handlers = {},
}, user_config.neotree or {}))

local map = require("cosmic.utils").map
map("n", "<C-n>", "<Cmd>Neotree left toggle reveal_force_cwd<CR>")
