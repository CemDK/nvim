local neoscroll = require "neoscroll"
local scrollbar_util = require "scrollbar.utils"

neoscroll.setup {
    easing = "linear", -- "quadratic", "sine", "linear", "circular"
    duration_multiplier = 0.1,

    -- nvim-scrollbar glitches out when scrolling with neoscroll
    -- this is a workaround to hide the scrollbar when scrolling
    -- ignored_events also works, looks better but is less performant
    pre_hook = function()
        scrollbar_util.hide()
    end,
    post_hook = function()
        scrollbar_util.show()
    end,
    -- ignored_events = {},
}

local keymap = {
    ["<C-u>"] = function()
        neoscroll.ctrl_u { duration = 10 }
    end,
    ["<C-d>"] = function()
        neoscroll.ctrl_d { duration = 10 }
    end,
    ["<C-b>"] = function()
        neoscroll.ctrl_b { duration = 200 }
    end,
    ["<C-f>"] = function()
        neoscroll.ctrl_f { duration = 200 }
    end,
    ["zt"] = function()
        neoscroll.zt { half_win_duration = 100 }
    end,
    ["zz"] = function()
        neoscroll.zz { half_win_duration = 100 }
    end,
    ["zb"] = function()
        neoscroll.zb { half_win_duration = 100 }
    end,
}
local modes = { "n", "v", "x" }
for key, func in pairs(keymap) do
    vim.keymap.set(modes, key, func)
end
