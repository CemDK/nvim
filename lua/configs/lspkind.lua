-- setup() is also available as an alias
--

require("lspkind").init {
    -- DEPRECATED (use mode instead): enables text annotations
    --
    -- default: true
    -- with_text = true,

    -- defines how annotations are shown
    -- default: symbol
    -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
    mode = "symbol",

    -- default symbol map
    -- can be either 'default' (requires nerd-fonts font) or
    -- 'codicons' for codicon preset (requires vscode-codicons font)
    --
    -- default: 'default'
    -- preset = "codicons",
    preset = "default",

    -- override preset symbols
    --
    -- default: {}
    symbol_map = {
        -- Function = "󰊕",
        -- Color = "󱓻",
        Array = "[]",
        BladeNav = "",
        Boolean = "",
        Calendar = "",
        Class = "󰠱",
        Codeium = "",
        Color = "󰏘",
        Constant = "󰏿",
        Constructor = "",
        Copilot = "",
        Enum = "",
        EnumMember = "",
        Event = "",
        Field = "󰜢",
        File = "󰈚",
        Folder = "󰉋",
        Function = "󰆧",
        Interface = "",
        Keyword = "󰌋",
        Method = "󰆧",
        Module = "",
        Namespace = "󰌗",
        Null = "󰟢",
        Number = "",
        Object = "󰅩",
        Operator = "󰆕",
        Package = "",
        Property = "󰜢",
        Reference = "󰈇",
        Snippet = "",
        String = "󰉿",
        Struct = "󰙅",
        Supermaven = "",
        TabNine = "",
        Table = "",
        Tag = "",
        Text = "󰉿",
        TypeParameter = "󰊄",
        Unit = "󰑭",
        Value = "󰎠",
        Variable = "󰀫",
        Watch = "󰥔",
    },
}
