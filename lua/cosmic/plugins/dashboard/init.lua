local icons = require("cosmic.theme.icons")
local db = require("dashboard")
local colors = require("cosmic.theme.colors")

vim.api.nvim_set_hl(0, "DashboardHeader", { fg = colors.normal })
vim.api.nvim_set_hl(0, "DashboardCenter", { fg = colors.insert })
vim.api.nvim_set_hl(0, "DashboardShortCut", { fg = colors.visual })

db.custom_header = {
    "",
    "",
    "",
    "",
    "",
    "",
    " ██████╗ ██████╗ ███████╗███╗   ███╗██╗ ██████╗███╗   ██╗██╗   ██╗██╗███╗   ███╗",
    "██╔════╝██╔═══██╗██╔════╝████╗ ████║██║██╔════╝████╗  ██║██║   ██║██║████╗ ████║",
    "██║     ██║   ██║███████╗██╔████╔██║██║██║     ██╔██╗ ██║██║   ██║██║██╔████╔██║",
    "██║     ██║   ██║╚════██║██║╚██╔╝██║██║██║     ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",
    "╚██████╗╚██████╔╝███████║██║ ╚═╝ ██║██║╚██████╗██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║",
    " ╚═════╝ ╚═════╝ ╚══════╝╚═╝     ╚═╝╚═╝ ╚═════╝╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
    "",
    "",
    "",
}

db.session_directory = vim.fn.stdpath("data") .. "/sessions"

db.custom_center = {
    {
        icon = icons.file1 .. " ",
        icon_hl = { fg = colors.hint },
        desc = "Find File                      ",
        shortcut = "LDR f f",
        action = "lua require('telescope.builtin').find_files()",
    },
    {
        icon = icons.file1 .. " ",
        icon_hl = { fg = colors.hint },
        desc = "Find MRU                       ",
        shortcut = "LDR f o",
        action = "lua require('telescope.builtin').oldfiles()",
    },
    {
        icon = icons.file1 .. " ",
        icon_hl = { fg = colors.hint },
        desc = "Find MRU in CWD                ",
        shortcut = "LDR F O",
        action = "lua require('telescope.builtin').oldfiles({ only_cwd = true })",
    },
    {
        icon = icons.file2 .. " ",
        icon_hl = { fg = colors.hint },
        desc = "File Manager                   ",
        shortcut = "CTRL n ",
        action = "Neotree left toggle reveal",
    },
    {
        icon = icons.word .. " ",
        icon_hl = { fg = colors.hint },
        desc = "Live Grep                      ",
        shortcut = "LDR f s",
        action = "lua require('telescope.builtin').live_grep()",
    },
    {
        icon = icons.clock .. " ",
        icon_hl = { fg = colors.hint },
        desc = "Load Session                   ",
        shortcut = "LDR s l",
        action = "lua vim.cmd(':silent RestoreSession')",
    },
    {
        icon = icons.error .. " ",
        icon_hl = { fg = colors.hint },
        desc = "Quit                           ",
        shortcut = "q      ",
        action = "quit",
    },
}

vim.cmd([[
    augroup dashboard_keymap
        au!
        au FileType dashboard nnoremap <buffer> q <Cmd>quit<CR>
    augroup end
]])
