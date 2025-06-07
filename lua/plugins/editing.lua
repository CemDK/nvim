-- Editing enhancements and text manipulation plugins
return {
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

            -- require("mini.surround").setup {}
            require("mini.icons").setup {}
            require("mini.align").setup {}
            -- require("mini.comment").setup {}
        end,
    },
    {
        --TODO: leap.nvim adds keybindings for 's' and 'S' in normal mode
        -- which conflicts with mini.surround
        -- right now this does not work
        -- have to configure mini.surround with new keybindings
        "echasnovski/mini.surround",
        -- Add/delete/replace surrounding text objects ( brackets, quotes, etc. )
        --
        -- gzaiw" - [S]urround [A]dd [I]nside [W]ord ["] double quotes
        -- gzd' - [S]urround [D]elete ['] single quote
        -- gzr)' - [S]urround [R]eplace [)] parenthesis with ['] single quote
        opts = {
            mappings = {
                add = "gza", -- Add surrounding in Normal and Visual modes
                delete = "gzd", -- Delete surrounding
                find = "gzf", -- Find surrounding (to the right)
                find_left = "gzF", -- Find surrounding (to the left)
                highlight = "gzh", -- Highlight surrounding
                replace = "gzr", -- Replace surrounding
                update_n_lines = "gzn", -- Update `n_lines`
            },
        },
        keys = {
            { "gz", "", desc = "+surround" },
        },
    },

    {
        "tpope/vim-sleuth",
    },
    {
        "ggandor/flit.nvim",
        enabled = true,
        keys = function()
            ---@type LazyKeysSpec[]
            local ret = {}
            for _, key in ipairs { "f", "F", "t", "T" } do
                ret[#ret + 1] = { key, mode = { "n", "x", "o" } }
            end
            return ret
        end,
        opts = { labeled_modes = "nx" },
    },
    {
        "ggandor/leap.nvim",
        enabled = true,
        keys = {
            { "s", mode = { "n", "x", "o" }, desc = "Leap Forward to" },
            { "S", mode = { "n", "x", "o" }, desc = "Leap Backward to" },
            { "gs", mode = { "n", "x", "o" }, desc = "Leap from Windows" },
        },
        config = function(_, opts)
            local leap = require "leap"
            for k, v in pairs(opts) do
                leap.opts[k] = v
            end
            leap.add_default_mappings(true)
            vim.keymap.del({ "x", "o" }, "x")
            vim.keymap.del({ "x", "o" }, "X")
        end,
    },
}
