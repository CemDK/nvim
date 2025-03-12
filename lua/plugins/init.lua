return {
    -- -------------------------------------------------------------------------------
    -- LSP & HIGHLIGHTS & COMPLETION CONFIG
    -- -------------------------------------------------------------------------------
    {
        "stevearc/conform.nvim",
        opts = require "configs.conform",
        event = "BufWritePre",
    },
    {
        "github/copilot.vim",
        lazy = false,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "williamboman/mason.nvim",
                -- opts = require "configs.mason",
            },
            {
                "williamboman/mason-lspconfig.nvim",
            },
            {
                "WhoIsSethDaniel/mason-tool-installer.nvim",
                opts = require "configs.mason-tool-installer",
            },
            {
                "j-hui/fidget.nvim",
            },
            {
                "hrsh7th/cmp-nvim-lsp",
            },
            -- {
            --     "nvimtools/none-ls.nvim",
            --     dependencies = {
            --         "nvim-lua/plenary.nvim",
            --     },
            --     config = function()
            --         local null_ls = require "null-ls"
            --         print "hello from none-ls"
            --         null_ls.setup {
            --             sources = {
            --                 null_ls.builtins.formatting.stylua,
            --                 null_ls.builtins.completion.spell,
            --                 -- require "none-ls.diagnostics.eslint", -- requires none-ls-extras.nvim
            --             },
            --         }
            --     end,
            -- },
        },
        config = function()
            require "configs.lspconfig"
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        build = ":TSUpdate",
        opts = function()
            return require "configs.treesitter"
        end,
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
    {
        "hrsh7th/nvim-cmp",
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
                "saadparwaiz1/cmp_luasnip",
                {
                    "L3MON4D3/LuaSnip",
                    build = "make install_jsregexp",
                },
                {
                    "L3MON4D3/cmp-luasnip-choice",
                    config = function()
                        require("cmp_luasnip_choice").setup {
                            auto_open = true,
                        }
                    end,
                },

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
                -- "hrsh7th/copilot.vim",
                "zbirenbaum/copilot-cmp",
                -- {
                --     "zbirenbaum/copilot.lua",
                --     cmd = "Copilot",
                --     event = "InsertEnter",
                --     config = function()
                --         require("copilot").setup {}
                --     end,
                -- },

                -- icons
                "onsails/lspkind.nvim",

                -- "saadparwaiz1/cmp_luasnip",
            },
        },
        config = function()
            require "configs.cmp"
        end,
    },
    {
        "onsails/lspkind.nvim",
        config = function()
            require "configs.lspkind"
        end,
    },

    -- {
    --     "HiPhish/rainbow-delimiters.nvim",
    --     enabled = false,
    --     lazy = true,
    -- },

    -- -------------------------------------------------------------------------------
    -- QoL
    -- -------------------------------------------------------------------------------
    {
        "kdheepak/lazygit.nvim",
        lazy = false,
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
        },
        opts = require "configs.lazygit",
        config = function()
            require("telescope").load_extension "lazygit"
        end,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        lazy = false,
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "DaikyXendo/nvim-material-icon",
            -- "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        config = function()
            require "configs.neo-tree"
        end,
    },
    {
        "rmagatti/auto-session",
        lazy = false,

        ---@module "auto-session"
        ---@type AutoSession.Config
        opts = {
            suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        },
    },
    {
        "wakatime/vim-wakatime",
        lazy = false,
    },
    {
        "tpope/vim-sleuth",
    },
    {
        "j-hui/fidget.nvim",
        lazy = false,
        opts = {},
    },
    {
        "echasnovski/mini.nvim",
        lazy = false,
        version = "*",
        confg = function()
            require("mini.nvim").setup()
            require("mini.surround").setup()
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
            -- {
            --     "lewis6991/gitsigns.nvim",
            --     config = function()
            --         require("gitsigns").setup()
            --         require("scrollbar.handlers.gitsigns").setup()
            --     end,
            -- },
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
        },
    },
    {
        -- INFO: keep this, so nvchad doesn't load nvim-tree with default settings
        "nvim-tree/nvim-tree.lua",
        enabled = false,
        lazy = false,
        version = "*",
        dependencies = {
            "DaikyXendo/nvim-material-icon",
            -- "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require "configs.nvim-tree"
        end,
    },
    {
        -- Highlight todo, notes, etc in comments
        "folke/todo-comments.nvim",
        event = "VimEnter",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = { signs = true },
    },
    {
        "sindrets/diffview.nvim",
        lazy = false,
        config = true,
        opts = {},
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        opts = {},
    },
    {
        "karb94/neoscroll.nvim",
        lazy = false,
        config = function()
            require "configs.neoscroll"
        end,
    },
}
