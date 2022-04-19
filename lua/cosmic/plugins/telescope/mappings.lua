local map = require("cosmic.utils").map
local M = {}

M.project_files = function()
    local opts = {} -- define here if you want to define something
    local ok = pcall(require("telescope.builtin").git_files, opts)
    if not ok then
        require("telescope.builtin").find_files(opts)
    end
end

M.init = function()
    map(
        "n",
        "<Leader>ff",
        "<Cmd>lua require('telescope.builtin').find_files({ hidden = false, no_ignore = false })<CR>"
    )
    map(
        "n",
        "<Leader>fF",
        "<Cmd>lua require('telescope.builtin').find_files()<CR>"
    )
    map(
        "n",
        "<Leader>Ff",
        "<Cmd>lua require('telescope.builtin').find_files({ cwd = require('telescope.utils').buffer_dir() })<CR>"
    )
    map(
        "n",
        "<Leader>FF",
        "<Cmd>lua require('telescope.builtin').find_files({ cwd = require('telescope.utils').buffer_dir(), hidden = false, no_ignore = false })<CR>"
    )
    map(
        "n",
        "<Leader>fo",
        "<Cmd>lua require('telescope.builtin').oldfiles()<CR>"
    )
    map(
        "n",
        "<Leader>FO",
        "<Cmd>lua require('telescope.builtin').oldfiles({ only_cwd = true })<CR>"
    )
    map(
        "n",
        "<Leader>fb",
        "<Cmd>lua require('telescope.builtin').buffers()<CR>"
    )
    map(
        "n",
        "<Leader>FB",
        "<Cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>"
    )
    map(
        "n",
        "<Leader>fs",
        "<Cmd>lua require('telescope.builtin').live_grep()<CR>"
    )
    map(
        "n",
        "<Leader>FS",
        "<Cmd>lua require('telescope.builtin').live_grep({ cwd = require('telescope.utils').buffer_dir() })<CR>"
    )
    map(
        "n",
        "<Leader>fw",
        "<Cmd>lua require('telescope.builtin').grep_string()<CR>"
    )
    map(
        "n",
        "<Leader>FW",
        "<Cmd>lua require('telescope.builtin').grep_string({ cwd = require('telescope.utils').buffer_dir() })<CR>"
    )
    map("n", "<Leader>fr", "<Cmd>lua require('telescope.builtin').resume()<CR>")
    map(
        "n",
        "<Leader>fp",
        "<Cmd>lua require('telescope.builtin').builtin({ include_extensions = true })<CR>"
    )
end

return M
