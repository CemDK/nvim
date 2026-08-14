-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua

---@class ChadrcConfig
local M = {}

M.base46 = {
    theme = "oat",

    transparency = false,

    -- theme-agnostic overrides only; theme-specific tweaks live in each
    -- theme's polish_hl (lua/themes/*.lua)
    hl_override = {
        Directory = { fg = "folder_bg" },
        DiagnosticHint = { fg = "grey" },
        FloatBorder = { fg = "sun" },
        Variable = { fg = "yellow" },
        Include = { fg = "purple" },
        -- Constant = { fg = "sun" }, -- already default

        ["@comment"] = { italic = true },
        ["@variable"] = { fg = "yellow" },
        ["@function"] = { fg = "blue" },
        ["@function.call"] = { fg = "blue" },
        ["@keyword"] = { fg = "purple" },
        ["@keyword.function"] = { fg = "magenta" },
        ["@operator"] = { fg = "cyan" },
        ["@punctuation.bracket"] = { fg = "yellow" },
        ["@punctuation.delimiter"] = { fg = "white" },
        ["@tag.delimiter"] = { fg = "white" },
    },

    hl_add = {
        DarkerBG = { bg = "darker_black" },
        -- not defined by base46's integrations, so it goes here instead of hl_override
        ["@tag.builtin"] = { fg = "red" },
    },

    integrations = {
        "dap",
        "hop",
        "telescope",
    },
}

M.colorify = {
    enabled = false,
    mode = "bg", -- fg, bg, virtual
    virt_text = "󱓻 ",
    highlight = { hex = true, lspvars = true },
}

-- M.nvdash = { load_on_startup = true }
M.ui = {
    statusline = {
        enabled = true,
        theme = "default",           -- default/vscode/vscode_colored/minimal
        separator_style = "default", -- default/round/block/arrow
    },
    cmp = {
        icons = true,
        lspkind_text = true,
        style = "atom_colored",
        format_colors = {
            tailwind = false,
        },
    },
    telescope = {
        style = "borderless",
    },
    tabufline = {
        enabled = true,
        lazyload = true,
        order = { "neoTreeOffset", "buffers", "tabs", "btns" },
        modules = {
            neoTreeOffset = function()
                local function getNeoTreeWidth()
                    for _, win in pairs(vim.api.nvim_tabpage_list_wins(0)) do
                        if vim.bo[vim.api.nvim_win_get_buf(win)].ft == "neo-tree" then
                            return vim.api.nvim_win_get_width(win)
                        end
                    end
                    return 0
                end
                return "%#NeoTreeNormal#" .. string.rep(" ", getNeoTreeWidth())
            end,
        },
    },
}

M.term = {
    base46_colors = true,
    winopts = { number = false },
    sizes = { sp = 0.3, vsp = 0.2, ["bo sp"] = 0.3, ["bo vsp"] = 0.2 },
    float = {
        relative = "editor",
        row = 0.1,
        col = 0.2,
        width = 0.6,
        height = 0.8,
        border = "none", -- "single", "double", "rounded", "solid", "shadow", "none"
    },
}

M.lsp = {
    signature = false,
}

return M
