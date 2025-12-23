-- Neovide settings
vim.g.neovide_refresh_rate = 144
vim.g.neovide_refresh_rate_idle = 5
vim.g.neovide_fullscreen = false
vim.g.neovide_profiler = false
vim.o.guifont = vim.fn.hostname() == "Cem-Ryzen" and "RobotoMono Nerd Font:h10" or "MesloLGS Nerd Font:h14"

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
vim.g.neovide_window_blurred = false -- for macOS only atm
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
vim.keymap.set("n", "<C-v>", '"+P') -- Paste normal mode
vim.keymap.set("v", "<C-v>", '"+P') -- Paste visual mode
vim.keymap.set("c", "<C-v>", "<C-R>+") -- Paste command mode
vim.keymap.set("i", "<C-v>", '<ESC>l"+Pli') -- Paste insert mode

-- Allow clipboard copy paste in neovim
vim.api.nvim_set_keymap("", "<C-v>", "+p<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("!", "<C-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<C-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-v>", "<C-R>+", { noremap = true, silent = true })

-- Neovide terminal colors
vim.g.terminal_color_0 = "#005F60"
vim.g.terminal_color_1 = "#ff4500"
vim.g.terminal_color_2 = "#8ec07c"
vim.g.terminal_color_3 = "#f78104"
vim.g.terminal_color_4 = "#268bd2"
vim.g.terminal_color_5 = "#a277ff"
vim.g.terminal_color_6 = "#2aa198"
vim.g.terminal_color_7 = "#a6b2b2"
vim.g.terminal_color_8 = "#003c3d"
vim.g.terminal_color_9 = "#ff7f50"
vim.g.terminal_color_10 = "#a9d196"
vim.g.terminal_color_11 = "#ffa940"
vim.g.terminal_color_12 = "#5eafed"
vim.g.terminal_color_13 = "#c4a6ff"
vim.g.terminal_color_14 = "#4ec2b8"
vim.g.terminal_color_15 = "#7a8787"
vim.g.terminal_ansi_colors = {
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

vim.g.highlight_Terminal = "guibg=#005F60 guifg=#93a1a1"
