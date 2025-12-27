---@class vim.var_accessor
local global = vim.g


-- Neovide settings
global.neovide_refresh_rate = 144
global.neovide_refresh_rate_idle = 5
global.neovide_fullscreen = false
global.neovide_profiler = false
vim.o.guifont = vim.fn.hostname() == "Cem-Ryzen" and "RobotoMono Nerd Font:h10" or "MesloLGS Nerd Font:h12"

-- Text rendering
vim.opt.linespace = -2
global.neovide_text_gamma = 0.0
global.neovide_text_contrast = 0.5 -- Ayo I dunno what values are good here, I don't see any difference

-- Cursor
global.neovide_cursor_antialiasing = true
global.neovide_cursor_animation_length = 0.100
global.neovide_cursor_short_animation_length = 0.04
global.neovide_cursor_trail_size = 1.0
global.neovide_cursor_animate_in_insert_mode = true
global.neovide_cursor_animate_command_line = true
-- global.neovide_cursor_vfx_mode = "railgun"
-- global.neovide_cursor_trail_size = 0.5

-- Padding

if vim.fn.hostname() == "Cem-Ryzen" then
    global.neovide_padding_bottom = 1
    global.neovide_padding_top = 1
    global.neovide_padding_right = 0
    global.neovide_padding_left = 1
else
    global.neovide_padding_bottom = 16
    global.neovide_padding_top = 16
    global.neovide_padding_right = 16
    global.neovide_padding_left = 16
end

-- Floating windows shadow
global.neovide_floating_shadow = true
global.neovide_floating_z_height = 5
global.neovide_light_angle_degrees = 75
global.neovide_light_radius = 5
global.neovide_floating_corner_radius = 0.0

-- Opacity
global.neovide_opacity = vim.fn.hostname() == "Cem-Ryzen" and 1.0 or 1 --0.90
global.neovide_normal_opacity = 1
global.neovide_window_blurred = false                                  -- for macOS only atm
global.neovide_floating_blur_amount_x = 2.0
global.neovide_floating_blur_amount_y = 2.0
--
global.neovide_position_animation_length = 0.15

-- Scrolling
global.neovide_scroll_animation_length = 0.3
global.neovide_scroll_animation_far_lines = 1

-- Misc
--global.neovide_cursor_hack = true
global.neovide_hide_mouse_when_typing = true

-- Keybindings
global.neovide_input_macos_option_key_is_meta =
"only_left"                                 -- Interprets Alt + whatever actually as <M-whatever>, instead of sending the actual special character to Neovim.
vim.keymap.set("n", "<C-v>", '"+P')         -- Paste normal mode
vim.keymap.set("v", "<C-v>", '"+P')         -- Paste visual mode
vim.keymap.set("c", "<C-v>", "<C-R>+")      -- Paste command mode
vim.keymap.set("i", "<C-v>", '<ESC>l"+Pli') -- Paste insert mode

-- Allow clipboard copy paste in neovim
vim.api.nvim_set_keymap("", "<C-v>", "+p<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("!", "<C-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<C-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-v>", "<C-R>+", { noremap = true, silent = true })

-- Neovide terminal colors
global.terminal_color_0 = "#005F60"
global.terminal_color_1 = "#ff4500"
global.terminal_color_2 = "#8ec07c"
global.terminal_color_3 = "#f78104"
global.terminal_color_4 = "#268bd2"
global.terminal_color_5 = "#a277ff"
global.terminal_color_6 = "#2aa198"
global.terminal_color_7 = "#a6b2b2"
global.terminal_color_8 = "#003c3d"
global.terminal_color_9 = "#ff7f50"
global.terminal_color_10 = "#a9d196"
global.terminal_color_11 = "#ffa940"
global.terminal_color_12 = "#5eafed"
global.terminal_color_13 = "#c4a6ff"
global.terminal_color_14 = "#4ec2b8"
global.terminal_color_15 = "#7a8787"
global.terminal_ansi_colors = {
    "#005F60",
    "#ff4500",
    "#8ec07c",
    "#f78104",
    "#268bd2",
    "#a277ff",
    "#2aa198",
    "#a6b2b2",
    "#003c3d",
    "#ff7f50",
    "#a9d196",
    "#ffa940",
    "#5eafed",
    "#c4a6ff",
    "#4ec2b8",
    "#7a8787",
}

global.highlight_Terminal = "guibg=#005F60 guifg=#93a1a1"
