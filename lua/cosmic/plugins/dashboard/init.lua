local icons = require("cosmic.theme.icons")
local g = vim.g

g.dashboard_enable_session = false

g.dashboard_custom_header = {
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

g.dashboard_default_executive = "telescope"

g.dashboard_session_directory = vim.fn.stdpath("data") .. "/sessions"

g.dashboard_custom_section = {
    find_file = {
        description = { icons.file1 .. " Find File           <Leader>ff" },
        command = "lua require('telescope.builtin').find_files()",
    },
    find_old_file = {
        description = { icons.file1 .. " Find MRU            <Leader>fo" },
        command = "lua require('telescope.builtin').oldfiles()",
    },
    find_old_file_cwd = {
        description = { icons.file1 .. " Find MRU in cwd     <Leader>FO" },
        command = "lua require('telescope.builtin').oldfiles({ only_cwd = true })",
    },
    file_explorer = {
        description = { icons.file2 .. " File Manager        <C-n>     " },
        command = "NvimTreeToggle",
    },
    find_string = {
        description = { icons.word .. " Live Grep           <Leader>fs" },
        command = "lua require('telescope.builtin').live_grep()",
    },
    last_session = {
        description = { icons.clock .. " Load Session        <Leader>sl" },
        command = "lua vim.cmd(':silent RestoreSession')",
    },
    quit = {
        description = { icons.error .. " Quit                q         " },
        command = "quit",
    },
}

vim.cmd([[
    augroup dashboard_keymap
        au!
        au FileType dashboard nnoremap <buffer> q <Cmd>quit<CR>
    augroup end
]])
