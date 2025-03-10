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
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "williamboman/mason.nvim",
                opts = require "configs.mason",
            },
            {
                "j-hui/fidget.nvim",
                opts = {},
            },
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            require "configs.lspconfig"
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = require "configs.treesitter",
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            {
                "L3MON4D3/LuaSnip",
                build = (function()
                    -- Build Step is needed for regex support in snippets.
                    -- This step is not supported in many windows environments.
                    -- Remove the below condition to re-enable on windows.
                    if vim.fn.has "win32" == 1 or vim.fn.executable "make" == 0 then
                        return
                    end
                    return "make install_jsregexp"
                end)(),
                dependencies = {
                    -- `friendly-snippets` contains a variety of premade snippets.
                    --    See the README about individual language/framework/plugin snippets:
                    --    https://github.com/rafamadriz/friendly-snippets
                    -- {
                    --   'rafamadriz/friendly-snippets',
                    --   config = function()
                    --     require('luasnip.loaders.from_vscode').lazy_load()
                    --   end,
                    -- },
                },
            },
            "saadparwaiz1/cmp_luasnip",

            -- Adds other completion capabilities.
            --  nvim-cmp does not ship with all sources by default. They are split
            --  into multiple repos for maintenance purposes.
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp-signature-help",
        },
        -- opts = { require "configs.auto-complete" },
        config = function()
            -- See `:help cmp`
            local cmp = require "cmp"
            local luasnip = require "luasnip"
            luasnip.config.setup {}

            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = { completeopt = "menu,menuone,noinsert" },

                -- No, but seriously. Please read `:help ins-completion`, it is really good!
                mapping = cmp.mapping.preset.insert {
                    -- Select the [n]ext item
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    -- Select the [p]revious item
                    ["<C-p>"] = cmp.mapping.select_prev_item(),

                    -- Scroll the documentation window [b]ack / [f]orward
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),

                    -- Accept ([y]es) the completion.
                    --  This will auto-import if your LSP supports it.
                    --  This will expand snippets if the LSP sent a snippet.
                    ["<C-y>"] = cmp.mapping.confirm { select = true },

                    -- If you prefer more traditional completion keymaps,
                    -- you can uncomment the following lines
                    --['<CR>'] = cmp.mapping.confirm { select = true },
                    --['<Tab>'] = cmp.mapping.select_next_item(),
                    --['<S-Tab>'] = cmp.mapping.select_prev_item(),

                    -- Manually trigger a completion from nvim-cmp.
                    --  Generally you don't need this, because nvim-cmp will display
                    --  completions whenever it has completion options available.
                    ["<C-Space>"] = cmp.mapping.complete {},

                    -- Think of <c-l> as moving to the right of your snippet expansion.
                    --  So if you have a snippet that's like:
                    --  function $name($args)
                    --    $body
                    --  end
                    --
                    -- <c-l> will move you to the right of each of the expansion locations.
                    -- <c-h> is similar, except moving you backwards.
                    ["<C-l>"] = cmp.mapping(function()
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        end
                    end, { "i", "s" }),
                    ["<C-h>"] = cmp.mapping(function()
                        if luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        end
                    end, { "i", "s" }),

                    -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
                    --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
                },
                sources = {
                    {
                        name = "lazydev",
                        -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
                        group_index = 0,
                    },
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "path" },
                    { name = "nvim_lsp_signature_help" },
                },
            }
        end,
    },

    { -- You can easily change to a different colorscheme.
        -- Change the name of the colorscheme plugin below, and then
        -- change the command in the config to whatever the name of that colorscheme is.
        --
        -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
        "folke/tokyonight.nvim",
        priority = 1000, -- Make sure to load this before all the other start plugins.
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require("tokyonight").setup {
                styles = {
                    comments = { italic = false }, -- Disable italics in comments
                },
            }

            -- Load the colorscheme here.
            -- Like many other themes, this one has different styles, and you could load
            -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
            vim.cmd.colorscheme "tokyonight-night"
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
        config = function()
            local map = require "mini.map"
            require("mini.map").setup {
                integrations = {
                    -- map.gen_integration.builtin_search(),
                    -- map.gen_integration.gitsigns(),
                    -- map.gen_integration.diagnostic(),
                },
                symbols = {
                    encode = map.gen_encode_symbols.dot "4x2",
                },
                window = {
                    width = 1,
                    winblend = 50,
                },
            }
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
        "nvim-tree/nvim-tree.lua",
        -- INFO: keep this, so nvchad doesn't load nvim-tree with default settings
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
}
