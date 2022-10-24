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
    map("n", "<Leader>ff", function()
        require("telescope.builtin").find_files()
    end)
    map("n", "<Leader>fF", function()
        require("telescope.builtin").find_files({
            hidden = true,
            no_ignore = true,
            no_ignore_parent = true,
        })
    end)
    map("n", "<Leader>Ff", function()
        require("telescope.builtin").find_files({
            cwd = require("telescope.utils").buffer_dir(),
            hidden = true,
            no_ignore = true,
            no_ignore_parent = true,
        })
    end)
    map("n", "<Leader>FF", function()
        require("telescope.builtin").find_files({
            cwd = require("telescope.utils").buffer_dir(),
        })
    end)
    map("n", "<Leader>fo", function()
        require("telescope.builtin").oldfiles()
    end)
    map("n", "<Leader>FO", function()
        require("telescope.builtin").oldfiles({ only_cwd = true })
    end)
    map("n", "<Leader>fb", function()
        require("telescope.builtin").buffers()
    end)
    map("n", "<Leader>FB", function()
        require("telescope.builtin").current_buffer_fuzzy_find()
    end)
    map("n", "<Leader>fs", function()
        require("telescope.builtin").live_grep()
    end)
    map("n", "<Leader>fS", function()
        require("telescope.builtin").live_grep({ grep_open_files = true })
    end)
    map("n", "<Leader>FS", function()
        require("telescope.builtin").live_grep({
            cwd = require("telescope.utils").buffer_dir(),
        })
    end)
    map("n", "<Leader>fw", function()
        require("telescope.builtin").grep_string()
    end)
    map("n", "<Leader>fW", function()
        require("telescope.builtin").grep_string({ grep_open_files = true })
    end)
    map("n", "<Leader>FW", function()
        require("telescope.builtin").grep_string({
            cwd = require("telescope.utils").buffer_dir(),
        })
    end)
    map("n", "<Leader>fr", function()
        require("telescope.builtin").resume()
    end)
    map("n", "<Leader>fp", function()
        require("telescope.builtin").builtin({ include_extensions = true })
    end)
end

return M
