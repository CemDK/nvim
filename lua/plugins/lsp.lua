-- LSP, completion, and syntax highlighting plugins
return {
    -- -------------------------------------------------------------------------------
    -- LSP, COMPLETION & SYNTAX
    -- -------------------------------------------------------------------------------
    {
        "neovim/nvim-lspconfig",
        event = "User FilePost",
        dependencies = {
            -- "williamboman/mason.nvim",
            -- "williamboman/mason-lspconfig.nvim",
            { "mason-org/mason.nvim", version = "^1.11.0" },
            { "mason-org/mason-lspconfig.nvim", version = "^1.32.0" },
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
            -- "nvim-treesitter/nvim-treesitter-context",
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
                    -- config = function()
                    --     require "configs.luasnip"
                    -- end,
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
                -- "hrsh7th/cmp-vsnip",
                -- "hrsh7th/vim-vsnip",
                -- "echasnovski/mini.snippets",
                -- "abeldekat/cmp-mini-snippets",
                -- "dcampos/nvim-snippy",

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

                -- CSS, Colors, etc
                -- This completion source will pull from files defined in vim.g.css_variables_files.
                -- vim.g.css_variables_files = { "variables.css" }
                -- You probably will want to specify the files with global CSS variables on a per-project basis.
                -- Using Neovim's exrc setting, you can put a .nvim.lua file in the root of your project's directory with this defined there.
                "roginfarrer/cmp-css-variables",

                -- icons
                {
                    "onsails/lspkind.nvim",
                    config = function()
                        require "configs.lspkind"
                    end,
                },
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
    {
        -- Highlight colors
        "brenoprata10/nvim-highlight-colors",
        enabled = true,
        -- "0xKahi/nvim-highlight-colors",
        -- branch = "feat/add-oklch",
        event = "VimEnter",
        config = function()
            require "configs.nvim-highligh-colors"
        end,
    },
    {
        -- Show diagnostics in a nicer windows
        "folke/trouble.nvim",
        opts = {
            use_diagnostic_signs = true,
            modes = {
                diagnostics = {
                    auto_close = true,
                    -- cascade: find and only show errors first, then warnings, then hints
                    filter = function(items)
                        local severity = vim.diagnostic.severity.HINT
                        for _, item in ipairs(items) do
                            severity = math.min(severity, item.severity)
                        end
                        return vim.tbl_filter(function(item)
                            return item.severity == severity
                        end, items)
                    end,
                },
                lsp = {
                    win = {
                        size = 0.3,
                    },
                },
                symbols = {
                    desc = "Symbols",
                    mode = "lsp_document_symbols",
                    win = {
                        size = 0.3,
                    },
                },
            },
        },
        keys = {
            {
                "<leader>to",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Trouble: [O]pen",
            },
            {
                "<leader>tc",
                function()
                    vim.cmd "Trouble diagnostics close"
                    vim.cmd "Trouble qflist close"
                    vim.cmd "Trouble todo close"
                    vim.cmd "Trouble lsp close"
                    vim.cmd "Trouble symbols close"
                end,
                desc = "Trouble: [C]lose",
            },
            {
                "<leader>tb",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Trouble: [B]uffer Toggle",
            },
            {
                "<leader>ts",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Trouble: [S]ymbols Toggle",
            },
            {
                "<leader>tl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "Trouble: [L]SP Toggle",
            },
            {
                "<leader>tL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Trouble: [L]ocation List Toggle",
            },
            {
                "<leader>tq",
                "<cmd>cclose<cr><cmd>Trouble qflist toggle<cr>",
                desc = "Trouble: [Q]uickfix List Toggle",
            },
        },
    },
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        lazy = false,
        opts = {},
        config = function(_, opts)
            require("refactoring").setup(opts)
            -- require("refactoring").setup {}
            -- require("refactoring").refactor "Extract Function"
            -- require("refactoring").refactor "Extract Variable"
            -- require("refactoring").refactor "Extract Constant"
            -- require("refactoring").refactor "Inline Variable"
            -- require("refactoring").debug.print_var()
            -- require("refactoring").debug.print_stack()
        end,
    },
}
