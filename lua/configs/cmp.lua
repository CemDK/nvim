dofile(vim.g.base46_cache .. "cmp")

local cmp = require "cmp"
local luasnip = require "luasnip"
local lspkind = require "lspkind"

require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup {}

-- Integrate nvim-autopairs with cmp
-- local cmp_autopairs = require "nvim-autopairs.completion.cmp"
-- require("nvim-autopairs").setup()
-- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

local options = {
    -- view = {
    --     entries = {
    --         name = "custom",
    --         selection_order = "near_cursor",
    --     },
    -- },

    -- Disable completion suggestions when writing comments
    enabled = function()
        local context = require "cmp.config.context"
        if vim.api.nvim_get_mode().mode == "c" then
            return true
        else
            return not context.in_treesitter_capture "comment" and not context.in_syntax_group "Comment"
        end
    end,

    formatting = {
        format = function(entry, item)
            local color_item = require("nvim-highlight-colors").format(entry, { kind = item.kind })
            item = lspkind.cmp_format {
                -- any lspkind format settings here
                -- mode = "symbol",
                mode = "symbol_text",

                maxwidth = {
                    menu = 50,
                    abbr = 50,
                },

                menu = {
                    -- buffer = "[buf]",
                    nvim_lsp = "[LSP]",
                    nvim_lua = "[api]",
                    path = "[path]",
                    luasnip = "[snip]",
                    gh_issues = "[issues]",
                },

                ellipsis_char = "...",
                show_labelDetails = true,

                -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                ---@diagnostic disable-next-line: unused-local
                before = function(e, vim_item)
                    -- ...
                    return vim_item
                end,
            }(entry, item)

            if color_item.abbr_hl_group then
                item.kind_hl_group = color_item.abbr_hl_group
                item.kind = color_item.abbr
            end
            return item
        end,
    },

    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },

    -- window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
    -- },

    completion = {
        completeopt = "menu,menuone,noinsert",
    },

    -- Please read `:help ins-completion`, it is really good!
    mapping = cmp.mapping.preset.insert {
        ["<C-Space>"] = cmp.mapping.complete {},
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-y>"] = cmp.mapping.confirm { select = true },

        -- Scroll the documentation window [b]ack / [f]orward
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),

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
    },

    sources = {
        -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
        { name = "lazydev", group_index = 0 },
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "nvim_lua" },
        { name = "luasnip", max_item_count = 5 },
        { name = "luasnip_choice" },
        { name = "path", max_item_count = 5 },
        -- { name = "buffer", max_item_count = 3, keyword_length = 5 },
        -- { name = "copilot" },
    },
}

options = vim.tbl_deep_extend("force", options, require "nvchad.cmp")
cmp.setup(options)
