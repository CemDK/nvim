return {
    -- -------------------------------------------------------------------------------
    -- CORE & BASE DEPENDENCIES
    -- -------------------------------------------------------------------------------
    "nvim-lua/plenary.nvim",

    -- -------------------------------------------------------------------------------
    -- UI & THEMING
    -- -------------------------------------------------------------------------------
    {
        "nvchad/base46",
        build = function()
            require("base46").load_all_highlights()
        end,
    },
    {
        "nvchad/ui",
        lazy = false,
        config = function()
            require "nvchad"
        end,
    },
    {
        "nvzone/volt",
    },
    {
        "nvzone/menu",
    },
    {
        "nvzone/minty",
        cmd = { "Huefy", "Shades" },
    },
    {
        "nvim-tree/nvim-web-devicons",
        opts = function()
            dofile(vim.g.base46_cache .. "devicons")
            return { override = require "nvchad.icons.devicons" }
        end,
    },
    {
        "folke/which-key.nvim",
        keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
        cmd = "WhichKey",
        opts = function()
            dofile(vim.g.base46_cache .. "whichkey")
            return {}
        end,
    },
    {
        "petertriho/nvim-scrollbar",
        lazy = false,
        dependencies = {
            {
                "kevinhwang91/nvim-hlslens",
                config = function()
                    require("scrollbar.handlers.search").setup {}
                end,
            },
        },
        opts = {
            handle = {
                blend = 70,
                color = "grey",
            },
            marks = {
                Search = { color = "orange" },
                Error = { color = "red" },
                Warn = { color = "yellow" },
                Info = { color = "green" },
                Hint = { color = "cyan" },
                Misc = { color = "purple" },
            },
            excluded_filetypes = {
                "dropbar_menu",
                "dropbar_menu_fzf",
                "DressingInput",
                "cmp_docs",
                "cmp_menu",
                "noice",
                "prompt",
                "TelescopePrompt",
            },
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        enabled = true,
        event = "User FilePost",
        opts = {
            indent = { char = "│", highlight = "IblChar" },
            scope = { char = "│", highlight = "IblScopeChar" },
        },
        config = function(_, opts)
            dofile(vim.g.base46_cache .. "blankline")

            local hooks = require "ibl.hooks"
            hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
            require("ibl").setup(opts)

            dofile(vim.g.base46_cache .. "blankline")
        end,
    },
    {
        "karb94/neoscroll.nvim",
        lazy = false,
        config = function()
            require "configs.neoscroll"
        end,
    },
    {
        "j-hui/fidget.nvim",
        lazy = false,
        opts = {},
    },

    -- -------------------------------------------------------------------------------
    -- FILE NAVIGATION & MANAGEMENT
    -- -------------------------------------------------------------------------------
    {
        "nvim-neo-tree/neo-tree.nvim",
        lazy = false,
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "DaikyXendo/nvim-material-icon",
            -- "nvim-tree/nvim-web-devicons", -- I use nvim-material-icon instead
            "MunifTanjim/nui.nvim",
            "folke/snacks.nvim",
        },
        opts = function(_, opts)
            local Snacks = require "snacks"
            local function on_move(data)
                Snacks.rename.on_rename_file(data.source, data.destination)
            end
            local events = require "neo-tree.events"
            opts.event_handlers = opts.event_handlers or {}
            vim.list_extend(opts.event_handlers, {
                { event = events.FILE_MOVED, handler = on_move },
                { event = events.FILE_RENAMED, handler = on_move },
            })
        end,
        config = function()
            require "configs.neo-tree"
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        cmd = "Telescope",
        opts = function()
            return require "configs.telescope"
        end,
        config = function()
            -- return require "configs.telescope"
            -- require("telescope").setup(opts)
            -- require("telescope").load_extension "fzf"
            -- require("telescope").load_extension "lazygit"
        end,
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        opts = {},
    },

    -- -------------------------------------------------------------------------------
    -- GIT INTEGRATION
    -- -------------------------------------------------------------------------------
    {
        "lewis6991/gitsigns.nvim",
        event = "User FilePost",
        opts = function()
            return require "configs.gitsigns"
        end,
    },
    {
        "kdheepak/lazygit.nvim",
        lazy = false,
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        opts = require "configs.lazygit",
        config = function()
            --     require("telescope").load_extension "lazygit"
        end,
    },
    {
        "sindrets/diffview.nvim",
        lazy = false,
        config = true,
        opts = {},
    },

    -- -------------------------------------------------------------------------------
    -- AI TOOLS
    -- -------------------------------------------------------------------------------
    {
        "github/copilot.vim",
        lazy = false,
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        lazy = false,
        dependencies = {
            { "github/copilot.vim" },
            { "nvim-lua/plenary.nvim", branch = "master" },
        },
        -- build = "make tiktoken",
        opts = require "configs.copilot-chat",
    },

    -- -------------------------------------------------------------------------------
    -- LSP, COMPLETION & SYNTAX
    -- -------------------------------------------------------------------------------
    {
        "neovim/nvim-lspconfig",
        event = "User FilePost",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            -- "hrsh7th/cmp-nvim-lsp",
            {
                "WhoIsSethDaniel/mason-tool-installer.nvim",
                opts = require "configs.mason-tool-installer",
            },
            {
                "antosha417/nvim-lsp-file-operations",
                dependencies = {
                    "nvim-lua/plenary.nvim",
                    "nvim-neo-tree/neo-tree.nvim",
                },
            },
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup()
            require("lsp-file-operations").setup()
            require "configs.lspconfig"
        end,
    },
    {
        "stevearc/conform.nvim",
        opts = require "configs.conform",
        event = "BufWritePre",
    },
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/playground",
            "nvim-treesitter/nvim-treesitter-textobjects",
            "JoosepAlviste/nvim-ts-context-commentstring",
            "nvim-treesitter/nvim-treesitter-context",
        },
        opts = function()
            return require "configs.treesitter"
        end,
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },

    {
        "hrsh7th/nvim-cmp",
        enabled = true,
        dependencies = {
            {
                -- Full list of sources
                -- https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources

                --Snippets
                -- "hrsh7th/cmp-vsnip",
                -- "hrsh7th/vim-vsnip",
                -- "echasnovski/mini.snippets",
                -- "abeldekat/cmp-mini-snippets",
                -- "dcampos/nvim-snippy",
                {
                    "L3MON4D3/LuaSnip",
                    dependencies = "rafamadriz/friendly-snippets",
                    build = (function()
                        -- Build Step is needed for regex support in snippets.
                        -- This step is not supported in many windows environments.
                        -- Remove the below condition to re-enable on windows.
                        if vim.fn.has "win32" == 1 or vim.fn.executable "make" == 0 then
                            return
                        end
                        return "make install_jsregexp"
                    end)(),

                    opts = { history = true, updateevents = "TextChanged,TextChangedI" },

                    config = function(_, opts)
                        require("luasnip").config.set_config(opts)
                        require "configs.luasnip"
                    end,
                },
                {
                    "L3MON4D3/cmp-luasnip-choice",
                    config = function()
                        require("cmp_luasnip_choice").setup {
                            auto_open = true,
                        }
                    end,
                },

                "saadparwaiz1/cmp_luasnip",
                "hrsh7th/cmp-nvim-lua",
                -- Buffer
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-calc",
                -- LSP
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-nvim-lsp-signature-help",
                -- FS Paths
                "hrsh7th/cmp-path",
                -- Command line
                "hrsh7th/cmp-cmdline",
                -- AI
                "zbirenbaum/copilot-cmp",
                -- icons
                "onsails/lspkind.nvim",
                -- "saadparwaiz1/cmp_luasnip",
                -- autopairing of (){}[] etc
                -- {
                --     "windwp/nvim-autopairs",
                --     opts = {
                --         fast_wrap = {},
                --         disable_filetype = { "TelescopePrompt", "vim" },
                --     },
                --     config = function(_, opts)
                --         require("nvim-autopairs").setup(opts)
                --
                --         -- setup cmp for autopairs
                --         local cmp_autopairs = require "nvim-autopairs.completion.cmp"
                --         require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
                --     end,
                -- },
            },
        },
        config = function()
            require "configs.cmp"
        end,
    },
    {
        -- Icons for completion items
        "onsails/lspkind.nvim",
        config = function()
            require "configs.lspkind"
        end,
    },
    {
        "folke/ts-comments.nvim",
        lazy = false,
        opts = {},
        event = "VeryLazy",
        enabled = vim.fn.has "nvim-0.10.0" == 1,
    },
    {
        -- Highlight todo, notes, etc in comments
        "folke/todo-comments.nvim",
        event = "VimEnter",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = { signs = true },
    },

    -- -------------------------------------------------------------------------------
    -- EDITING ENHANCEMENTS
    -- -------------------------------------------------------------------------------
    {
        "echasnovski/mini.nvim",
        lazy = false,
        version = "*",
        config = function()
            -- Better Around/Inside text objects
            --
            -- Examples:
            -- va) - [V]isually select [A]round the [)] parenthesis
            -- yinq - [Y]ank [I]nside the [N]ext [Q]uote
            -- ci' - [C]hange [I]nside ['] single quote
            require("mini.ai").setup { n_lines = 500 }

            -- Add/delete/replace surrounding text objects ( brackets, quotes, etc. )
            --
            -- saiw" - [S]urround [A]dd [I]nside [W]ord ["] double quotes
            -- sd' - [S]urround [D]elete ['] single quote
            -- sr)' - [S]urround [R]eplace [)] parenthesis with ['] single quote
            require("mini.surround").setup {}
            require("mini.icons").setup {}
            -- require("mini.comment").setup {}
        end,
    },
    {
        "tpope/vim-sleuth",
    },

    -- -------------------------------------------------------------------------------
    -- SESSION & WORKSPACE
    -- -------------------------------------------------------------------------------
    {
        "rmagatti/auto-session",
        lazy = false,
        opts = {
            suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        },
    },
    {
        "wakatime/vim-wakatime",
        lazy = false,
    },

    -- -------------------------------------------------------------------------------
    -- UTILITY & ENHANCEMENTS
    -- -------------------------------------------------------------------------------
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            bigfile = { enabled = true },
            dashboard = { enabled = false },
            explorer = { enabled = false },
            git = { enabled = true },
            -- indent = { enabled = true },
            lazygit = { enabled = true },
            picker = { enabled = true },
            notifier = { enabled = true },
            notify = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = false },
            statuscolumn = { enabled = false },
            words = { enabled = false },

            ---@class snacks.dim.Config
            dim = {
                scope = {
                    min_size = 5,
                    max_size = 20,
                    siblings = true,
                },
                animate = {
                    enabled = vim.fn.has "nvim-0.10" == 1,
                    easing = "outQuad",
                    duration = {
                        step = 10, -- ms per step
                        total = 200, -- maximum duration
                    },
                },
                -- what buffers to dim
                filter = function(buf)
                    return vim.g.snacks_dim ~= false and vim.b[buf].snacks_dim ~= false and vim.bo[buf].buftype == ""
                end,
            },

            input = {
                enabled = true,
                animate = {
                    enabled = true,
                    style = "out",
                    -- easing = "linear",
                    duration = {
                        step = 10, -- ms per step
                        total = 50, -- maximum duration
                    },
                },
            },
        },
        init = function()
            vim.api.nvim_create_autocmd("User", {
                pattern = "VeryLazy",
                callback = function()
                    local Snacks = require "snacks"
                    -- Create some toggle mappings
                    -- Snacks.toggle.option("spell", { name = "Spelling" }):map "<leader>us"
                    -- Snacks.toggle.option("wrap", { name = "Wrap" }):map "<leader>uw"
                    -- Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map "<leader>uL"
                    -- Snacks.toggle.diagnostics():map "<leader>ud"
                    -- Snacks.toggle.line_number():map "<leader>ul"
                    -- Snacks.toggle
                    --     .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
                    --     :map "<leader>uc"
                    -- Snacks.toggle.treesitter():map "<leader>uT"
                    -- Snacks.toggle
                    --     .option("background", { off = "light", on = "dark", name = "Dark Background" })
                    --     :map "<leader>ub"
                    -- Snacks.toggle.inlay_hints():map "<leader>uh"
                    -- Snacks.toggle.indent():map "<leader>ug"
                    Snacks.toggle.dim():map "<leader>uD"
                end,
            })
        end,
    },
}
