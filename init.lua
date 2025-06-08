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
    vim.g.neovide_refresh_rate = 144
    vim.g.neovide_refresh_rate_idle = 5
    vim.g.neovide_fullscreen = false
    vim.g.neovide_profiler = false
    vim.o.guifont = "RobotoMono Nerd Font:h10"

    -- Text rendering
    vim.opt.linespace = -2
    vim.g.neovide_text_gamma = 0.0
    vim.g.neovide_text_contrast = 0.5 -- Ayo I dunno what values are good here, I don't see any difference

    -- Cursor
    vim.g.neovide_cursor_antialiasing = true
    vim.g.neovide_cursor_animation_length = 0.100
    vim.g.neovide_cursor_short_animation_length = 0.04
    vim.g.neovide_cursor_trail_size = 1.0
    vim.g.neovide_cursor_animate_in_insert_mode = true
    vim.g.neovide_cursor_animate_command_line = true
    -- vim.g.neovide_cursor_vfx_mode = "railgun"
    -- vim.g.neovide_cursor_trail_size = 0.5

    -- Padding
    vim.g.neovide_padding_bottom = 1
    vim.g.neovide_padding_top = 1
    vim.g.neovide_padding_right = 0
    vim.g.neovide_padding_left = 1

    -- Floating windows shadow
    vim.g.neovide_floating_shadow = true
    vim.g.neovide_floating_z_height = 5
    vim.g.neovide_light_angle_degrees = 75
    vim.g.neovide_light_radius = 5
    vim.g.neovide_floating_corner_radius = 0.0

    -- Opacity
    vim.g.neovide_opacity = 1 --0.98
    vim.g.neovide_normal_opacity = 1 --0.98
    -- vim.g.neovide_window_blurred = true          -- for macOS only atm
    -- vim.g.neovide_floating_blur_amount_x = 2.0   -- "" --
    -- vim.g.neovide_floating_blur_amount_y = 2.0   -- "" --
    --
    vim.g.neovide_position_animation_length = 0.15

    -- Scrolling
    vim.g.neovide_scroll_animation_length = 0.3
    vim.g.neovide_scroll_animation_far_lines = 1

    -- Misc
    --vim.g.neovide_cursor_hack = true
    vim.g.neovide_hide_mouse_when_typing = true

    -- Keybindings
    vim.g.neovide_input_macos_option_key_is_meta = "only_left" -- Interprets Alt + whatever actually as <M-whatever>, instead of sending the actual special character to Neovim.
end
