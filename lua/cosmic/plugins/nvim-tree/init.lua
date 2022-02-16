local config = require("cosmic.core.user")
local icons = require("cosmic.theme.icons")
local u = require("cosmic.utils")
local g = vim.g

-- settings
g.nvim_tree_git_hl = 1
g.nvim_tree_refresh_wait = 300

g.nvim_tree_special_files = {}

g.nvim_tree_icons = {
    default = "",
    symlink = icons.symlink,
    git = icons.git,
    folder = icons.folder,
    lsp = {
        hint = icons.hint,
        info = icons.info,
        warning = icons.warn,
        error = icons.error,
    },
}

g.nvim_tree_respect_buf_cwd = 1

-- set up args
local args = {
    auto_close = true,
    hijack_cursor = true,
    diagnostics = {
        enable = true,
        show_on_dirs = true,
    },
    ignore_ft_on_setup = {
        "startify",
        "dashboard",
        "alpha",
    },
    update_focused_file = {
        enable = true,
    },
    update_to_buf_dir = {
        enable = false,
    },
    view = {
        width = 35,
        number = true,
        relativenumber = true,
    },
    git = {
        ignore = false,
    },
}

require("nvim-tree").setup(u.merge(args, config.nvim_tree or {}))
require("cosmic.plugins.nvim-tree.mappings")
