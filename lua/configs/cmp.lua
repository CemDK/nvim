dofile(vim.g.base46_cache .. "cmp")

--TODO: fix this mess
--
---------------------------------------------------------------------------------------------------------------
-- NvChad format color function here
---------------------------------------------------------------------------------------------------------------
local api = vim.api
local cmp_ui = require("nvconfig").ui.cmp
local hlcache = {}

local format_color = function(entry, item)
    local color = entry.completion_item.documentation

    if color and type(color) == "string" and color:match "^#%x%x%x%x%x%x$" then
        local hl = "hex-" .. color:sub(2)

        if not hlcache[hl] then
            api.nvim_set_hl(0, hl, { bg = color, fg = "#abb2bf" })
            hlcache[hl] = true
        end

        item.kind_hl_group = hl
        -- item.menu_hl_group = hl
    end
end
---------------------------------------------------------------------------------------------------------------

local cmp_style = cmp_ui.style
-- local format_color = require "nvchad.cmp.format"

local atom_styled = cmp_style == "atom" or cmp_style == "atom_colored"
local fields = (atom_styled or cmp_ui.icons_left) and { "kind", "abbr", "menu" } or { "abbr", "kind", "menu" }

local cmp = require "cmp"
local luasnip = require "luasnip"
-- local lspkind = require "lspkind"

require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup {}

-- Integrate nvim-autopairs with cmp
-- local cmp_autopairs = require "nvim-autopairs.completion.cmp"
-- require("nvim-autopairs").setup()
-- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

local options = {
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
            local icons = require "nvchad.icons.lspkind"
            local icon = icons[item.kind] or ""
            local kind = item.kind or ""

            item.menu = kind
            item.menu_hl_group = "comment"
            item.kind = " " .. icon .. " "

            if kind == "Color" then
                format_color(entry, item)
                item.kind = " 󰏘 "
            end

            if #item.abbr > cmp_ui.abbr_maxwidth then
                item.abbr = string.sub(item.abbr, 1, cmp_ui.abbr_maxwidth) .. "…"
            end

            return item
        end,

        fields = fields,
    },

    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },

    -- window = {
    --     completion = cmp.config.window.bordered(),
    --     documentation = cmp.config.window.bordered(),
    -- },

    window = {
        completion = {
            scrollbar = false,
            side_padding = 0,
            winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None,FloatBorder:CmpBorder",
            border = "none",
        },

        documentation = {
            border = "none",
            winhighlight = "Normal:CmpDoc,FloatBorder:CmpDocBorder",
        },
    },

    completion = {
        -- completeopt = "menu,menuone,noinsert",
        completeopt = "menu,menuone",
    },

    -- Please read `:help ins-completion`, it is really good!
    mapping = cmp.mapping.preset.insert {
        ["<C-Space>"] = cmp.mapping.complete {},
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-y>"] = cmp.mapping.confirm { select = true },
        ["<C-z>"] = cmp.mapping.confirm { select = true },

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
        { name = "css-variables" },
        { name = "luasnip", max_item_count = 3 },
        { name = "luasnip_choice", max_item_count = 3 },
        { name = "path", max_item_count = 3 },
        { name = "cmdline" },
        -- { name = "buffer", max_item_count = 3, keyword_length = 5 },
        -- { name = "copilot" },
    },
}

-- cmp.setup.cmdline({ "/", "?" }, {
--     mapping = cmp.mapping.preset.cmdline(),
--     sources = {
--         { name = "buffer" },
--     },
-- })

-- options = vim.tbl_deep_extend("force", options, require "nvchad.cmp")
-- options = vim.tbl_deep_extend("force", require "nvchad.cmp", options)

cmp.setup(options)
