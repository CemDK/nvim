vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "
vim.g.have_nerd_font = true

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    local repo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
---@diagnostic disable-next-line: different-requires
require("lazy").setup({
    { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "syntax")
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
    require "mappings"
end)

-- require "configs.rainbow"
require "highlights"

if vim.g.neovide then
    -- vim.g.neovide_cursor_vfx_mode = "railgun"
    -- vim.g.neovide_cursor_animation_length = 0.13
    -- vim.g.neovide_cursor_trail_size = 0.5
    -- vim.g.neovide_cursor_antialiasing = true
    vim.g.neovide_refresh_rate = 144
    -- vim.g.neovide_floating_blur_amount_x = 2.0
    -- vim.g.neovide_floating_blur_amount_y = 2.0
end
