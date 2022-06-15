local icons = require("cosmic.theme.icons")
local db = require("dashboard")

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
        desc = "Find File                      ",
        shortcut = "<Leader>ff",
        action = "lua require('telescope.builtin').find_files()",
    },
    {
        icon = icons.file1 .. " ",
        desc = "Find MRU                       ",
        shortcut = "<Leader>fo",
        action = "lua require('telescope.builtin').oldfiles()",
    },
    {
        icon = icons.file1 .. " ",
        desc = "Find MRU in cwd                ",
        shortcut = "<Leader>FO",
        action = "lua require('telescope.builtin').oldfiles({ only_cwd = true })",
    },
    {
        icon = icons.file2 .. " ",
        desc = "File Manager                   ",
        shortcut = "<C-n>     ",
        action = "Neotree left toggle reveal",
    },
    {
        icon = icons.word .. " ",
        desc = "Live Grep                      ",
        shortcut = "<Leader>fs",
        action = "lua require('telescope.builtin').live_grep()",
    },
    {
        icon = icons.clock .. " ",
        desc = "Load Session                   ",
        shortcut = "<Leader>sl",
        action = "lua vim.cmd(':silent RestoreSession')",
    },
    {
        icon = icons.error .. " ",
        desc = "Quit                           ",
        shortcut = "q         ",
        action = "quit",
    },
}

local colors = require("cosmic.theme.colors")

vim.cmd("hi default DashboardHeader guifg=" .. colors.normal)
vim.cmd("hi default DashboardCenter guifg=" .. colors.normal)
vim.cmd("hi default DashboardCenterIcon guifg=" .. colors.insert)
vim.cmd("hi default DashboardShortCut guifg=" .. colors.visual)

vim.cmd([[
    augroup dashboard_keymap
        au!
        au FileType dashboard nnoremap <buffer> q <Cmd>quit<CR>
    augroup end
]])
