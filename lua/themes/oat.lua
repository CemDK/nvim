-- oat (orange-and-teal)

---@class OatTheme: Base46Table
local M = {}

M.base_30 = {
    white = "#a6b2b2",         -- oklch(0.7542 0.0134 196.87)
    darker_black = "#041d24",  -- oklch(0.2150 0.0338 219.21)
    black = "#062027",         -- oklch(0.2273 0.0341 218.65)
    black2 = "#102a31",        -- oklch(0.2680 0.0343 217.79)
    one_bg = "#0d323b",        -- oklch(0.2956 0.0439 217.05)
    one_bg2 = "#123f49",       -- oklch(0.3421 0.0507 215.39)
    one_bg3 = "#174c57",       -- oklch(0.3871 0.0573 214.20)
    grey = "#3d5a5f",          -- oklch(0.4467 0.0353 209.37)
    grey_fg = "#47666b",       -- oklch(0.4881 0.0369 208.50)
    grey_fg2 = "#517277",      -- oklch(0.5287 0.0386 207.75)
    light_grey = "#5c7e83",    -- oklch(0.5691 0.0392 207.40)
    statusline_bg = "#102a31", -- oklch(0.2680 0.0343 217.79)
    lightbg = "#123f49",       -- oklch(0.3421 0.0507 215.39)
    line = "#0d323b",          -- oklch(0.2956 0.0439 217.05)
    folder_bg = "#90a4ae",     -- oklch(0.7064 0.0268 229.31)
    -- red = "#eb603c",        -- oklch(0.6608 0.1799 35.52) old
    red = "#e45f69",           -- oklch(0.6561 0.1656 18.37)
    orange = "#f78104",        -- oklch(0.7225 0.1779 55.10)
    sun = "#ffa940",           -- oklch(0.8023 0.1530 67.23)
    yellow = "#e8b654",        -- oklch(0.8032 0.1284 81.87)
    green = "#8fc17d",         -- oklch(0.7587 0.1077 137.67)
    vibrant_green = "#a9d196", -- oklch(0.8169 0.0908 135.80)
    teal = "#2aa198",          -- oklch(0.6437 0.1019 187.38)
    cyan = "#4bc6c5",          -- oklch(0.7588 0.1076 194.36)
    blue = "#31a6f9",          -- oklch(0.7003 0.1577 244.97)
    nord_blue = "#74b8f1",     -- oklch(0.7597 0.1076 245.17)
    pink = "#e484cf",          -- oklch(0.7401 0.1492 335.59)
    baby_pink = "#dc97cc",     -- oklch(0.7605 0.1072 335.31)
    purple = "#a787f5",        -- oklch(0.6993 0.1587 295.40)
    dark_purple = "#815fcc",   -- oklch(0.5720 0.1626 295.15)
    magenta = "#c77bdc",       -- oklch(0.6988 0.1580 318.71)


    pmenu_bg = "#f78104", -- oklch(0.7225 0.1779 55.10)
}

M.base_16 = {
    base00 = M.base_30.black,   -- Default Background
    base01 = M.base_30.one_bg,  -- Lighter Background (status bars, line numbers)
    base02 = M.base_30.one_bg2, -- Selection Background
    base03 = M.base_30.one_bg3, -- Comments, Invisibles, Line Highlighting
    base04 = "#35545a",         -- Dark Foreground (status bars)
    base05 = "#93a1a1",         -- Default Foreground, Delimiters, Operators
    base06 = "#a6b2b2",         -- Light Foreground
    base07 = "#c5cece",         -- Light Background
    base08 = M.base_30.red,     -- Variables, XML Tags, Diff Deleted
    base09 = M.base_30.sun,     -- Integers, Booleans, Constants
    base0A = M.base_30.yellow,  -- Classes, Types, Search Text Background
    base0B = M.base_30.green,   -- Strings, Diff Inserted
    base0C = M.base_30.cyan,    -- Support, Regular Expressions, Escape Characters
    base0D = M.base_30.blue,    -- Functions, Methods, Headings
    base0E = M.base_30.purple,  -- Keywords, Storage, Diff Changed
    base0F = "#cc3700",         -- Deprecated, Delimiters (original dim red)
}

M.polish_hl = {
    defaults = {
        IncSearch = { fg = M.base_30.sun, bg = "none", standout = true },
    },

    lsp = {
        DiagnosticVirtualTextError = { bg = "#472218", fg = M.base_30.red },
        DiagnosticVirtualTextWarn = { bg = "#44250c", fg = M.base_30.yellow },
        DiagnosticVirtualTextInfo = { bg = "#0f304a", fg = M.base_30.blue },
        DiagnosticVirtualTextHint = { bg = "#003632", fg = M.base_30.teal },
    },
}

M.type = "dark"

M = require("base46").override_theme(M, "oat")

return M
