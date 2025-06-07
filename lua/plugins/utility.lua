-- Utility and enhancement plugins
return {
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
    {
        "folke/edgy.nvim",
        enabled = true,
        event = "VeryLazy",
        init = function()
            vim.opt.laststatus = 3
            vim.opt.splitkeep = "screen"
        end,
        opts = function()
            local opts = {
                animate = {
                    enabled = false,
                },
                left = {
                    -- Neo-tree filesystem always takes half the screen height
                    {
                        title = "Files",
                        ft = "neo-tree",
                        filter = function(buf)
                            return vim.b[buf].neo_tree_source == "filesystem"
                        end,
                        size = {
                            height = 0.7,
                            width = 40,
                        },
                        pinned = true,
                        collapsed = false,
                    },
                    {
                        title = "Git Status",
                        ft = "neo-tree",
                        filter = function(buf)
                            return vim.b[buf].neo_tree_source == "git_status"
                        end,
                        size = {
                            height = 0.2,
                            width = 40,
                        },
                        pinned = true,
                        collapsed = false,
                        open = "Neotree position=bottom git_status",
                    },
                    "neo-tree",
                },
                right = {
                    {
                        title = "Symbols",
                        ft = "trouble",
                        ---@diagnostic disable-next-line: unused-local
                        filter = function(_buf, win)
                            return vim.w[win].trouble
                                and vim.w[win].trouble.position == "right"
                                and vim.w[win].trouble.mode == "symbols"
                                and vim.w[win].trouble.type == "split"
                                and vim.w[win].trouble.relative == "editor"
                                and not vim.w[win].trouble_preview
                        end,
                        size = { width = 0.3 },
                    },
                    {
                        title = "LSP",
                        ft = "trouble",
                        ---@diagnostic disable-next-line: unused-local
                        filter = function(_buf, win)
                            return vim.w[win].trouble
                                and vim.w[win].trouble.mode == "lsp"
                                and vim.w[win].trouble.position == "right"
                                and vim.w[win].trouble.type == "split"
                                and vim.w[win].trouble.relative == "editor"
                                and not vim.w[win].trouble_preview
                        end,
                        size = { width = 0.3 },
                    },
                },
                bottom = {
                    {
                        title = "Diagnostics",
                        ft = "trouble",
                        ---@diagnostic disable-next-line: unused-local
                        filter = function(_buf, win)
                            return vim.w[win].trouble
                                and vim.w[win].trouble.position == "bottom"
                                and vim.w[win].trouble.type == "split"
                                and vim.w[win].trouble.relative == "editor"
                                and not vim.w[win].trouble_preview
                        end,
                        size = { height = 0.25 },
                    },
                    {
                        title = "QuickFix",
                        ft = "qf",
                        size = { height = 0.2 },
                    },
                    {
                        ft = "help",
                        size = { height = 0.4 },
                        -- only show help buffers
                        filter = function(buf)
                            return vim.bo[buf].buftype == "help"
                        end,
                    },
                    { ft = "spectre_panel", size = { height = 0.2 } },
                },
            }
            return opts
        end,
    },
    {
        "Aasim-A/scrollEOF.nvim",
        event = { "CursorMoved", "WinScrolled" },
        opts = {},
    },
    {
        "m4xshen/hardtime.nvim",
        enabled = false,
        lazy = false,
        dependencies = { "MunifTanjim/nui.nvim" },
        opts = {},
    },
}
