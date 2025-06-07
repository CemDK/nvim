-- File navigation and management plugins
return {
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
            {
                "echasnovski/mini.icons",
                config = function()
                    require("mini.icons").setup {}
                end,
            },
            -- "saifulapm/neotree-file-nesting-config",
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
}
