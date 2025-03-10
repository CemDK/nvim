-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
    theme = "onedark",

    transparency = false,

    changed_themes = {
        onedark = {
            base_16 = {
                -- base00 = "#23272E", -- Default Background
                -- base01 = "#1e2227", -- Lighter Background (status bars, line number, folding marks)
                -- base02 = "#2c313c", -- Selection Background
                -- base03 = "#495162", -- Comments, Invisibles, Line Highlighting
                -- base04 = "#6b717d", -- Dark Foreground (status bars)
                -- base05 = "#abb2bf", -- Default Foreground, Caret, Delimiters, Operators
                -- base06 = "#d7dae0", -- Light Foreground (Not often used)
                -- base07 = "#f8fafd", -- Light Background (Not often used)
                -- base08 = "#e06c75", -- Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
                -- base09 = "#d19a66", -- Integers, Boolean, Constants, XML Attributes, Markup Link Url
                -- base0A = "#e5c07b", -- Classes, Markup Bold, Search Text Background
                -- base0B = "#98c379", -- Strings, Inherited Class, Markup Code, Diff Inserted
                -- base0C = "#56b6c2", -- Support, Regular Expressions, Escape Characters, Markup Quotes
                -- base0D = "#61afef", -- Functions, Methods, Attribute IDs, Headings
                -- base0E = "#c678dd", -- Keywords, Storage, Selector, Markup Italic, Diff Changed
                -- base0F = "#be5046", -- Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>
                base00 = "#23272E",
                base01 = "#1e2227",
                base02 = "#2c313c",
                base03 = "#495162",
                base04 = "#6b717d",
                base05 = "#abb2bf",
                base06 = "#d7dae0",
                base07 = "#f8fafd",
                base08 = "#e45f69",
                base09 = "#d89250",
                base0A = "#e8b654",
                base0B = "#8fc66b",
                base0C = "#4cb5ca",
                base0D = "#55a7f5",
                base0E = "#cb5fe8",
                base0F = "#c4483f",
            },
            base_30 = {
                black = "#23272E",
                darker_black = "#1e2227",
                black2 = "#282c34",
                one_bg = "#323842",
                one_bg2 = "#3b4048",
                one_bg3 = "#495162",
                baby_pink = "#de73ff",
                pink = "#c678dd",
                line = "#3e4452",
                vibrant_green = "#109868",
                nord_blue = "#4aa5f0",
                seablue = "#42b3c2",
                sun = "#f0a45d",
                dark_purple = "#c162de",
                teal = "#56b6c2",
                statusline_bg = "#23272E",
                lightbg = "#2c313c",
                pmenu_bg = "#61afef",
                folder_bg = "#90a4ae",
                yellow = "#E5C07B",
                blue = "#61AFEF",
                red = "#E06C75",
                green = "#98C379",
                purple = "#C678DD",
                orange = "#D19A66",
                cyan = "#56B6C2",
            },
        },
    },

    hl_override = {
        Include = { fg = "purple" },
        Directory = { fg = "folder_bg" },
        DiagnosticHint = { fg = "grey" },
        -- NeoTreeNormal = { bg = "#ffffff" },
        -- NeoTreeNormalNC = { bg = "#ffffff" },
        -- NeoTreeEndOfBuffer = { bg = "#ffffff" },

        ["@comment"] = { italic = true },
        ["@function.call"] = { fg = "blue" },
        ["@variable.typescript"] = { fg = "yellow" },
        ["@keyword"] = { fg = "purple" },
        ["@punctuation.bracket"] = { fg = "yellow" },
        ["@punctuation.delimiter"] = { fg = "#ABB2BF" },
        ["@function"] = { fg = "blue" },
        ["@operator"] = { fg = "cyan" },
        ["@tag.delimiter"] = { fg = "#ABB2BF" },
        ["@tag.builtin"] = { fg = "red" },
    },

    hl_add = {
        DarkerBG = { bg = "darker_black" },
    },

    integrations = {
        "dap",
        "hop",
        "telescope",
    },
}

-- M.nvdash = { load_on_startup = true }
M.ui = {
    theme = "onedark",
    tabufline = {
        lazyload = false,
    },
    statusline = {
        theme = "default",
    },
}

return M
