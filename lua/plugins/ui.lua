-- UI, theming, and visual enhancements
return {
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
        -- Color picking tool
        "nvzone/minty",
        cmd = { "Shades", "Huefy" },
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
        opts = {
            dofile(vim.g.base46_cache .. "whichkey"),
            preset = "helix",
            -- delay = 0,
            win = {
                padding = { 3, 4 },
                height = { min = 30 },
                title = false,
                -- title_pos = "center",
            },
        },
    },
    {
        "petertriho/nvim-scrollbar",
        enabled = true,
        lazy = false,
        dependencies = {
            {
                "kevinhwang91/nvim-hlslens",
                enabled = false,
                config = function()
                    require("scrollbar.handlers.search").setup {}
                end,
            },
            {
                "karb94/neoscroll.nvim",
                lazy = false,
                config = function()
                    require "configs.neoscroll"
                end,
            },
        },
        opts = {
            handle = {
                blend = 80,
                color = "grey",
            },
            marks = {
                Search = { color = "orange" },
                Error = { color = "red" },
                Warn = { color = "yellow" },
                Info = { color = "green" },
                Hint = { color = "cyan" },
                Misc = { color = "purple" },
                Cursor = { text = " ", priority = 1000 }, -- disable cursor mark and don't hide other marks when cursor is on them
            },
            excluded_filetypes = {
                "neo-tree",
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
        config = function()
            dofile(vim.g.base46_cache .. "blankline")
            local highlight = {
                "RainbowRed",
                "RainbowYellow",
                "RainbowBlue",
                "RainbowOrange",
                "RainbowGreen",
                "RainbowViolet",
                "RainbowCyan",
            }

            local hooks = require "ibl.hooks"
            hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
            hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
                vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
                vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
                vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
                vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
                vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
                vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
            end)

            vim.g.rainbow_delimiters = { highlight = highlight }
            require("ibl").setup {
                -- set indent to highlight for rainbow indents
                indent = { priority = 2, char = "▏", highlight = "IblChar" },
                scope = { priority = 1, char = "▏", highlight = "RainbowRed" },
            }

            dofile(vim.g.base46_cache .. "blankline")
        end,
    },
    {
        "j-hui/fidget.nvim",
        lazy = false,
        opts = {},
    },
    {
        "mikesmithgh/borderline.nvim",
        enabled = false,
        lazy = true,
        event = "VeryLazy",
        config = function()
            require("borderline").setup {
                --  ...
            }
        end,
    },
}
