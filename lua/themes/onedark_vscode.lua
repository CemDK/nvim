-- onedark_vscode
-- VSCode-like onedark (more vibrant colors)

---@class OnedarkVscodeTheme: Base46Table
local M = {}

M.base_30 = {
    white = "#abb2bf",
    darker_black = "#1e2227",
    black = "#23272E",  -- nvim bg
    black2 = "#2c313c",
    one_bg = "#323842", -- vscode onedark bg, some other onedark: #282c34
    one_bg2 = "#3b4048",
    one_bg3 = "#495162",
    grey = "#6b717d",
    grey_fg = "#5d626d",
    grey_fg2 = "#565c69",
    light_grey = "#6f7580",
    statusline_bg = "#23272E",
    lightbg = "#2c313c",
    line = "#31353d", -- for lines like vertsplit
    -- line = "#3e4452",
    folder_bg = "#90a4ae",
    red = "#e45f69",
    sun = "#f0a45d",
    orange = "#D19A66",
    yellow = "#e8b654",
    -- vibrant_green = "#109868",
    green = "#98C379",
    vibrant_green = "#7eca9c",
    teal = "#56b6c2",
    -- seablue = "#42b3c2",
    cyan = "#56B6C2",
    blue = "#61AFEF",
    pmenu_bg = "#61afef",
    -- nord_blue = "#4aa5f0",
    nord_blue = "#81A1C1",
    -- pink = "#cb5fe8",
    -- baby_pink = "#cb5fe8",
    -- purple = "#cb5fe8",
    -- dark_purple = "#cb5fe8",
    pink = "#ff75a0",
    baby_pink = "#DE8C92",
    purple = "#de98fd",
    dark_purple = "#c882e7",
}

M.base_16 = {
    -- nvchad onedark colors:
    -- base00 = "#1e222a",
    -- base01 = "#353b45",
    -- base02 = "#3e4451",
    -- base03 = "#545862",
    -- base04 = "#565c64",
    -- base05 = "#abb2bf",
    -- base06 = "#b6bdca",
    -- base07 = "#c8ccd4",
    -- base08 = "#e06c75",
    -- base09 = "#d19a66",
    -- base0A = "#e5c07b",
    -- base0B = "#98c379",
    -- base0C = "#56b6c2",
    -- base0D = "#61afef",
    -- base0E = "#c678dd",
    -- base0F = "#be5046",

    base00 = "#23272E", -- Default Background
    base01 = "#1e2227", -- Lighter Background (status bars, line number, folding marks)
    base02 = "#2c313c", -- Selection Background
    base03 = "#495162", -- Comments, Invisibles, Line Highlighting
    base04 = "#6b717d", -- Dark Foreground (status bars)
    base05 = "#abb2bf", -- Default Foreground, Caret, Delimiters, Operators
    base06 = "#d7dae0", -- Light Foreground (Not often used)
    base07 = "#f8fafd", -- Light Background (Not often used)
    base08 = "#e45f69", -- Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
    base09 = "#d89250", -- Integers, Boolean, Constants, XML Attributes, Markup Link Url
    base0A = "#e8b654", -- Classes, Markup Bold, Search Text Background
    base0B = "#8fc66b", -- Strings, Inherited Class, Markup Code, Diff Inserted
    base0C = "#4cb5ca", -- Support, Regular Expressions, Escape Characters, Markup Quotes
    base0D = "#55a7f5", -- Functions, Methods, Attribute IDs, Headings
    base0E = "#cb5fe8", -- Keywords, Storage, Selector, Markup Italic, Diff Changed
    base0F = "#c4483f", -- Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>
}

M.polish_hl = {
    statusline = {
        St_Macro = { fg = M.base_30.red, bold = true },
    },

    syntax = {
        Include = { fg = M.base_30.purple },
    },
}

M.type = "dark"

M = require("base46").override_theme(M, "onedark_vscode")

return M
