local M = {}

function M.map(mode, lhs, rhs, opts)
    local options = { remap = false, silent = true }
    if opts then
        options = M.merge(options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

function M.buf_map(bufnr, mode, lhs, rhs, opts)
    local options = { buffer = bufnr, remap = false, silent = true }
    if opts then
        options = M.merge(options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

function M.merge_list(tbl1, tbl2)
    for _, v in ipairs(tbl2) do
        table.insert(tbl1, v)
    end
    return tbl1
end

function M.merge(...)
    return vim.tbl_deep_extend("force", ...)
end

function M.split(str, sep)
    local res = {}
    for w in str:gmatch("([^" .. sep .. "]*)") do
        if w ~= "" then
            table.insert(res, w)
        end
    end
    return res
end

function M.get_active_lsp_client_names()
    local active_clients = vim.lsp.get_active_clients()
    local client_names = {}
    for _, client in pairs(active_clients or {}) do
        local buf = vim.api.nvim_get_current_buf()
        -- only return attached buffers
        if vim.lsp.buf_is_attached(buf, client.id) then
            table.insert(client_names, client.name)
        end
    end

    if not vim.tbl_isempty(client_names) then
        table.sort(client_names)
    end
    return client_names
end

local function unload(module_pattern, reload)
    reload = reload or false
    for module, _ in pairs(package.loaded) do
        if module:match(module_pattern) then
            package.loaded[module] = nil
            if reload then
                require(module)
            end
        end
    end
end

local function clear_cache()
    if
        0
        == vim.fn.delete(vim.fn.stdpath("config") .. "/lua/cosmic/compiled.lua")
    then
        vim.cmd(":LuaCacheClear")
    end
end

function M.post_reload(msg)
    local Logger = require("cosmic.utils.logger")
    unload("cosmic.utils", true)
    unload("cosmic.theme", true)
    unload("cosmic.plugins.statusline", true)
    msg = msg or "User config reloaded!"
    Logger:log(msg)
end

function M.reload_user_config_sync()
    M.reload_user_config()
    clear_cache()
    unload("cosmic.core.user", true)
    unload("cosmic.core.pluginsInit", true)
    vim.cmd(
        [[autocmd User PackerCompileDone ++once lua require('cosmic.utils').post_reload()]]
    )
    vim.cmd(":PackerSync")
end

function M.reload_user_config(compile)
    compile = compile or false
    unload("cosmic.core.user", true)
    if compile then
        vim.cmd(
            [[autocmd User PackerCompileDone ++once lua require('cosmic.utils').post_reload()]]
        )
        vim.cmd(":PackerCompile")
    end
end

function M.get_install_dir()
    local config_dir = os.getenv("COSMICNVIM_INSTALL_DIR")
    if not config_dir then
        return vim.fn.stdpath("config")
    end
    return config_dir
end

-- update instance of CosmicNvim
function M.update()
    local Logger = require("cosmic.utils.logger")
    local Job = require("plenary.job")
    local path = M.get_install_dir()
    local errors = {}

    Job
        :new({
            command = "git",
            args = { "pull", "--ff-only" },
            cwd = path,
            on_start = function()
                Logger:log("Updating...")
            end,
            on_exit = function()
                if vim.tbl_isempty(errors) then
                    Logger:log("Updated! Running CosmicReloadSync...")
                    M.reload_user_config_sync()
                else
                    table.insert(
                        errors,
                        1,
                        "Something went wrong! Please pull changes manually."
                    )
                    table.insert(errors, 2, "")
                    Logger:error("Update failed!", { timeout = 30000 })
                end
            end,
            on_stderr = function(_, err)
                table.insert(errors, err)
            end,
        })
        :sync()
end

-- M.snippets_clear = function()
--     local ls = require("luasnip")
--     local config_path = vim.fn.stdpath("config") .. "/lua/snippets"
--
--     for m, _ in pairs(ls.snippets) do
--         package.loaded["snippets." .. m] = nil
--     end
--
--     ls.snippets = setmetatable({}, {
--         __index = function(t, k)
--             local ok, m = pcall(require, "snippets." .. k)
--             if not ok and not string.match(m, "^module.*not found:") then
--                 error(m)
--             end
--             t[k] = ok and m.snippets or {}
--             if k ~= "all" then
--                 require("luasnip.loaders.from_vscode").load({
--                     include = { k },
--                 })
--             end
--             return t[k]
--         end,
--     })
--
--     if vim.fn.filereadable(config_path .. "/package.json") then
--         require("luasnip.loaders.from_vscode").load({ paths = config_path })
--     end
--
--     if vim.fn.filereadable(config_path .. "/local.lua") then
--         if package.loaded["snippets.local"] then
--             package.loaded["snippets.local"] = nil
--         end
--
--         local ok, m = pcall(require, "snippets.local")
--         if ok and m.snippets then
--             for k, v in pairs(m.snippets) do
--                 ls.snippets[k] = M.merge(ls.snippets[k], v)
--             end
--         end
--     end
--
--     for _, f in
--         ipairs(vim.tbl_filter(function(filename)
--             return vim.fn.fnamemodify(filename, ":e") == "lua"
--                 and filename ~= "local.lua"
--         end, vim.fn.readdir(config_path)))
--     do
--         local ok, m = pcall(require, "snippets." .. vim.fn.fnamemodify(f, ":r"))
--         if ok and m.map_snippets then
--             m.map_snippets()
--         end
--     end
-- end
--
-- M.edit_snippets_ft = function()
--     local fts = require("luasnip.util.util").get_snippet_filetypes()
--     vim.ui.select(fts, {
--         prompt = "Select which snippet filetype to edit:",
--     }, function(item, idx)
--         if idx then
--             vim.cmd(
--                 "edit "
--                     .. vim.fn.stdpath("config")
--                     .. "/lua/snippets/"
--                     .. item
--                     .. ".lua"
--             )
--         end
--     end)
-- end

return M
