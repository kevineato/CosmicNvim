local present, cosmic_packer = pcall(require, "cosmic.packer")

if not present then
    return false
end

local packer = cosmic_packer.packer
local use = packer.use

local ok, user_config = pcall(require, "cosmic.core.user")
if not ok then
    user_config = {
        add_plugins = {},
        disable_builtin_plugins = {},
    }
end

return packer.startup(function()
    use({
        "wbthomason/packer.nvim",
        "lewis6991/impatient.nvim",
        "nathom/filetype.nvim",
        "nvim-lua/plenary.nvim",
    })

    -- initialize theme plugins
    require("cosmic.theme.plugins").init(use, user_config)

    use({
        "rcarriga/nvim-notify",
        config = function()
            require("cosmic.plugins.notify")
        end,
        after = user_config.theme,
        disable = vim.tbl_contains(
            user_config.disable_builtin_plugins,
            "notify"
        ),
    })

    -- theme stuff
    use({ -- statusline
        "NTBBloodbath/galaxyline.nvim",
        branch = "main",
        requires = { "kyazdani42/nvim-web-devicons" },
        config = function()
            require("cosmic.plugins.galaxyline")
        end,
        after = user_config.theme,
        disable = vim.tbl_contains(
            user_config.disable_builtin_plugins,
            "galaxyline"
        ),
    })

    -- file explorer
    -- use({
    --     "kyazdani42/nvim-tree.lua",
    --     config = function()
    --         require("cosmic.plugins.nvim-tree")
    --     end,
    --     opt = true,
    --     keys = {
    --         { "n", "<C-n>" },
    --         { "n", user_config.mapleader.as_code .. "fn" },
    --     },
    --     cmd = {
    --         "NvimTreeClipboard",
    --         "NvimTreeClose",
    --         "NvimTreeFindFile",
    --         "NvimTreeOpen",
    --         "NvimTreeRefresh",
    --         "NvimTreeToggle",
    --     },
    --     disable = vim.tbl_contains(
    --         user_config.disable_builtin_plugins,
    --         "nvim-tree"
    --     ),
    -- })
    use({
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        keys = {
            { "n", "<C-n>" },
        },
        cmd = { "Neotree" },
        config = function()
            require("cosmic.plugins.neo-tree")
        end,
    })

    use({
        "CosmicNvim/cosmic-ui",
        requires = {
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("cosmic.plugins.cosmic-ui")
        end,
    })

    use({
        "neovim/nvim-lspconfig",
        config = function()
            require("cosmic.lsp")
        end,
        requires = {
            { "b0o/SchemaStore.nvim" },
            { "williamboman/nvim-lsp-installer" },
            { "jose-elias-alvarez/nvim-lsp-ts-utils" },
            {
                "jose-elias-alvarez/null-ls.nvim",
                config = function()
                    require("cosmic.lsp.providers.null_ls")
                end,
                disable = vim.tbl_contains(
                    user_config.disable_builtin_plugins,
                    "null-ls"
                ),
                after = "nvim-lspconfig",
            },
            {
                "ray-x/lsp_signature.nvim",
                config = function()
                    require("cosmic.plugins.lsp-signature")
                end,
                after = "nvim-lspconfig",
                disable = vim.tbl_contains(
                    user_config.disable_builtin_plugins,
                    "lsp_signature"
                ),
            },
        },
    })

    -- autocompletion
    use({
        "hrsh7th/nvim-cmp",
        config = function()
            require("cosmic.plugins.nvim-cmp")
        end,
        requires = {
            -- {
            --     "L3MON4D3/LuaSnip",
            --     config = function()
            --         require("cosmic.plugins.luasnip")
            --     end,
            --     requires = {
            --         "rafamadriz/friendly-snippets",
            --     },
            -- },
            -- { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
            {
                "SirVer/ultisnips",
                config = function()
                    local g = vim.g
                    g.UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
                    g.UltiSnipsJumpForwardTrigger =
                        "<Plug>(ultisnips_jump_forward)"
                    g.UltiSnipsJumpBackwardTrigger =
                        "<Plug>(ultisnips_jump_backward)"
                    g.UltiSnipsRemoveSelectModeMappings = 0

                    require("cosmic.utils").map(
                        "x",
                        "<Tab>",
                        ":call UltiSnips#SaveLastVisualSelection()<CR>gvc"
                    )
                end,
            },
            {
                "quangnguyen30192/cmp-nvim-ultisnips",
                config = function()
                    vim.cmd([[
                        augroup cmp_ultisnips
                            au!
                            au BufWritePost *.snippets CmpUltisnipsReloadSnippets
                        augroup end
                    ]])
                end,
                after = { "nvim-cmp", "ultisnips" },
            },
            { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
            { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
            { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
            { "hrsh7th/cmp-path", after = "nvim-cmp" },
            { "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
            {
                "windwp/nvim-autopairs",
                config = function()
                    require("cosmic.plugins.auto-pairs")
                end,
                after = "nvim-cmp",
            },
        },
        event = { "CmdlineEnter", "InsertEnter" },
        disable = vim.tbl_contains(
            user_config.disable_builtin_plugins,
            "nvim-cmp"
        ),
    })

    -- git commands
    use({
        "tpope/vim-fugitive",
        opt = true,
        cmd = "Git",
        disable = vim.tbl_contains(
            user_config.disable_builtin_plugins,
            "fugitive"
        ),
    })

    -- git column signs
    use({
        "lewis6991/gitsigns.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        opt = true,
        event = "BufRead",
        config = function()
            require("cosmic.plugins.gitsigns")
        end,
        disable = vim.tbl_contains(
            user_config.disable_builtin_plugins,
            "gitsigns"
        ),
    })

    -- floating terminal
    use({
        "voldikss/vim-floaterm",
        opt = true,
        event = "BufWinEnter",
        config = function()
            require("cosmic.plugins.terminal")
        end,
        disable = vim.tbl_contains(
            user_config.disable_builtin_plugins,
            "terminal"
        ),
    })

    -- file navigation
    use({
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                run = "make",
            },
        },
        config = function()
            require("cosmic.plugins.telescope.mappings").init()
            require("cosmic.plugins.telescope")
        end,
        event = "BufWinEnter",
        disable = vim.tbl_contains(
            user_config.disable_builtin_plugins,
            "telescope"
        ),
    })

    -- session/project management
    use({
        "glepnir/dashboard-nvim",
        config = function()
            require("cosmic.plugins.dashboard")
        end,
        after = user_config.theme,
        disable = vim.tbl_contains(
            user_config.disable_builtin_plugins,
            "dashboard"
        ),
    })

    use({
        "rmagatti/auto-session",
        config = function()
            require("cosmic.plugins.auto-session")
        end,
        disable = vim.tbl_contains(
            user_config.disable_builtin_plugins,
            "auto-session"
        ),
    })

    -- lang/syntax stuff
    use({
        "nvim-treesitter/nvim-treesitter",
        requires = {
            "windwp/nvim-ts-autotag",
            "JoosepAlviste/nvim-ts-context-commentstring",
            "nvim-treesitter/nvim-treesitter-refactor",
        },
        run = ":TSUpdate",
        config = function()
            require("cosmic.plugins.treesitter")
        end,
        disable = vim.tbl_contains(
            user_config.disable_builtin_plugins,
            "treesitter"
        ),
    })

    -- comments and stuff
    use({
        "numToStr/Comment.nvim",
        config = function()
            require("cosmic.plugins.comments")
        end,
        event = "BufWinEnter",
        disable = vim.tbl_contains(
            user_config.disable_builtin_plugins,
            "comment-nvim"
        ),
    })

    -- todo highlights
    use({
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("cosmic.plugins.todo-comments")
        end,
        event = "BufWinEnter",
        disable = vim.tbl_contains(
            user_config.disable_builtin_plugins,
            "todo-comments"
        ),
    })
    -- colorized hex codes
    use({
        "norcalli/nvim-colorizer.lua",
        opt = true,
        cmd = { "ColorizerToggle" },
        config = function()
            require("colorizer").setup()
        end,
        disable = vim.tbl_contains(
            user_config.disable_builtin_plugins,
            "colorizer"
        ),
    })

    if
        user_config.add_plugins and not vim.tbl_isempty(user_config.add_plugins)
    then
        for _, plugin in pairs(user_config.add_plugins) do
            use(plugin)
        end
    end

    if cosmic_packer.first_install then
        packer.sync()
    end
end)
