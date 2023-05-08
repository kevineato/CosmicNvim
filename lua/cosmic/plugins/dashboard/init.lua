local icons = require("cosmic.theme.icons")
local colors = require("cosmic.theme.colors")
local api = vim.api

api.nvim_set_hl(0, "DashboardHeader", { fg = colors.normal })
api.nvim_set_hl(0, "DashboardCenter", { fg = colors.insert })
api.nvim_set_hl(0, "DashboardShortCut", { fg = colors.visual })
api.nvim_set_hl(0, "DashboardIcon", { fg = colors.hint })

require("dashboard").setup({
    theme = "doom",
    config = {
        week_header = {
            enable = true,
        },
        center = {
            {
                icon = icons.file1 .. " ",
                desc = "Find File                      ",
                shortcut = "LDR f f",
                action = "lua require('telescope.builtin').find_files()",
            },
            {
                icon = icons.file1 .. " ",
                desc = "Find MRU                       ",
                shortcut = "LDR f o",
                action = "lua require('telescope.builtin').oldfiles()",
            },
            {
                icon = icons.file1 .. " ",
                desc = "Find MRU in CWD                ",
                shortcut = "LDR F O",
                action = "lua require('telescope.builtin').oldfiles({ only_cwd = true })",
            },
            {
                icon = icons.file2 .. " ",
                desc = "File Manager                   ",
                shortcut = "CTRL n ",
                action = "Neotree left toggle reveal",
            },
            {
                icon = icons.word .. " ",
                desc = "Live Grep                      ",
                shortcut = "LDR f s",
                action = "lua require('telescope.builtin').live_grep()",
            },
            {
                icon = icons.clock .. " ",
                desc = "Load Session                   ",
                shortcut = "LDR s l",
                action = "lua vim.cmd(':silent SessionRestore')",
            },
            {
                icon = icons.error .. " ",
                desc = "Quit                           ",
                shortcut = "q      ",
                action = "quit",
            },
        },
    },
})

vim.cmd([[
    augroup dashboard_keymap
        au!
        au FileType dashboard nnoremap <buffer> q <Cmd>quit<CR>
    augroup end
]])
