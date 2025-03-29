return {
    -- -------------------------------------------------------------------------------
    -- CORE
    -- -------------------------------------------------------------------------------
    "nvim-lua/plenary.nvim",

    -- -------------------------------------------------------------------------------
    -- UI
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

    -- -------------------------------------------------------------------------------
    -- AI
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
    -- LSP & HIGHLIGHTS & COMPLETION CONFIG
    -- -------------------------------------------------------------------------------
    {
        "stevearc/conform.nvim",
        opts = require "configs.conform",
        event = "BufWritePre",
    },
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

    -- {
    --     -- TODO: confiugre this further, still some issues with it for me,
    --     -- e.g. holding ctrl-n glitches the completion menu
    --     "saghen/blink.cmp",
    --     dependencies = { "rafamadriz/friendly-snippets" },
    --     version = "1.*",
    --     opts = {
    --         keymap = {
    --             preset = "default",
    --         },
    --
    --         completion = {
    --             menu = {
    --                 draw = {
    --                     columns = { { "label", "label_description", gap = 1 }, { "kind_icon" } },
    --                     components = {
    --                         kind_icon = {
    --                             -- text = function(ctx)
    --                             --     local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
    --                             --     return kind_icon
    --                             -- end,
    --                             -- (optional) use highlights from mini.icons
    --                             highlight = function(ctx)
    --                                 local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
    --                                 return hl
    --                             end,
    --                         },
    --                         kind = {
    --                             -- (optional) use highlights from mini.icons
    --                             highlight = function(ctx)
    --                                 local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
    --                                 return hl
    --                             end,
    --                         },
    --                     },
    --                 },
    --             },
    --             documentation = {
    --                 auto_show = true,
    --                 window = {
    --                     border = "",
    --                 },
    --             },
    --         },
    --
    --         signature = {
    --             window = {
    --                 border = "",
    --             },
    --         },
    --         -- Default list of enabled providers defined so that you can extend it
    --         -- elsewhere in your config, without redefining it, due to `opts_extend`
    --         sources = {
    --             default = { "lsp", "path", "snippets", "buffer" },
    --         },
    --         fuzzy = {
    --             implementation = "prefer_rust_with_warning",
    --             sorts = {
    --                 "exact",
    --                 -- defaults
    --                 "score",
    --                 "sort_text",
    --             },
    --         },
    --     },
    --     opts_extend = { "sources.default" },
    -- },
    --
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
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        opts = require "configs.lazygit",
        config = function()
            require("telescope").setup {
                extensions = {
                    fzf = {
                        fuzzy = true, -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true, -- override the file sorter
                        case_mode = "smart_case", -- "ignore_case" or "respect_case" or "smart_case"
                    },
                },
            }
            require("telescope").load_extension "fzf"
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
            -- "nvim-tree/nvim-web-devicons", -- I use nvim-material-icon instead
            "MunifTanjim/nui.nvim",
            "folke/snacks.nvim",
        },
        opts = function(_, opts)
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
    -- {
    --     "numToStr/Comment.nvim",
    --     lazy = false,
    --     opts = {
    --         -- add any options here
    --     },
    --     config = function()
    --         require("Comment").setup()
    --     end,
    -- },
    {
        "folke/ts-comments.nvim",
        lazy = false,
        opts = {},
        event = "VeryLazy",
        enabled = vim.fn.has "nvim-0.10.0" == 1,
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
    {
        "nvzone/menu",
        lazy = true,
        dependencies = {
            "nvzone/volt",
        },
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
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
                ---@type snacks.scope.Config
                scope = {
                    min_size = 5,
                    max_size = 20,
                    siblings = true,
                },
                ---@type snacks.animate.Config|{enabled?: boolean}
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
        "folke/which-key.nvim",
        keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
        cmd = "WhichKey",
        opts = function()
            dofile(vim.g.base46_cache .. "whichkey")
            return {}
        end,
    },

    -- git stuff
    {
        "lewis6991/gitsigns.nvim",
        event = "User FilePost",
        opts = function()
            return require "configs.gitsigns"
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        cmd = "Telescope",
        opts = function()
            return require "configs.telescope"
        end,
    },
}
