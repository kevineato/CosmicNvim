local config = require("cosmic.core.user")
local u = require("cosmic.utils")

local defaults = {
    ensure_installed = {
        "bash",
        "c",
        "cmake",
        "comment",
        "cpp",
        "css",
        "dockerfile",
        "html",
        "java",
        "javascript",
        "jsdoc",
        "json",
        "lua",
        "markdown",
        "python",
        "tsx",
        "typescript",
        "vim",
        "yaml",
    },
    highlight = {
        enable = true,
        use_languagetree = true,
    },
    indent = {
        enable = false,
    },
    autotag = {
        enable = true,
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    refactor = {
        highlight_definitions = { enable = true },
        highlight_current_scope = { enable = false },
    },
}

require("nvim-treesitter.configs").setup(
    u.merge(defaults, config.treesitter or {})
)
