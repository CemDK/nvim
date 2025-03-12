local neoscroll = require "neoscroll"
neoscroll.setup {
    -- post_hook = function(info)
    --     vim.api.nvim_feedkeys("zz", "n", false)
    -- end,
    easing = "sine", -- "quadratic", "sine", "linear", "circular"
}

local keymap = {
    ["<C-u>"] = function()
        neoscroll.ctrl_u { duration = 200 }
    end,
    ["<C-d>"] = function()
        neoscroll.ctrl_d { duration = 200 }
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
