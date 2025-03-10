local rainbow_delimiters = require "rainbow-delimiters"

vim.g.rainbow_delimiters = {
    strategy = {
        [""] = rainbow_delimiters.strategy["global"],
        vim = rainbow_delimiters.strategy["local"],
    },
    query = {
        [""] = "rainbow-delimiters",
        lua = "rainbow-blocks",
        typescript = "rainbow-delimiters",
        tsx = "rainbow-parens",
    },
    priority = {
        [""] = 110,
        lua = 210,
    },
    highlight = {
        "RainbowDelimiterCyan",
        "RainbowDelimiterYellow",
        "RainbowDelimiterViolet",
        "RainbowDelimiterOrange",
        "RainbowDelimiterGreen",
        "RainbowDelimiterBlue",
        -- "RainbowDelimiterRed",
    },
}
