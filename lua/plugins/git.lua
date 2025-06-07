-- Git integration plugins
return {
    -- -------------------------------------------------------------------------------
    -- GIT INTEGRATION
    -- -------------------------------------------------------------------------------
    -- {
    --     "lewis6991/gitsigns.nvim",
    --     enabled = true,
    --     event = "User FilePost",
    --     opts = function()
    --         return require "configs.gitsigns"
    --     end,
    -- },
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
}
