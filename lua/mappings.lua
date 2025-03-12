-- require "nvchad.mappings"
require "chad_mappings"

local map = function(mode, keys, func, desc)
    mode = mode or "n"
    vim.keymap.set(mode, keys, func, desc)
end

-- map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Control S to save and enter normal mode
map({ "i", "n", "v" }, "<C-s>", "<ESC>:w<RETURN>", { desc = "MINE: Save and go to normal mode" })

-- Select all
map("n", "<C-a>", "gg<S-v>G", { desc = "MINE: Select all" })

-- Save file and quit
map("n", "<leader>w", ":w<RETURN>", { desc = "MINE: [W]rite" })
map("n", "<leader>qq", ":wqa!<RETURN>", { desc = "MINE: [W]rite [A]ll and [Q]uit" })

-- Split window
map("n", "ss", ":split<RETURN>", { desc = "MINE: [S]lit [S]creen" })
map("n", "sv", ":vsplit<RETURN>", { desc = "MINE: [S]lit screen [V]ertically" })

-- LazyGit
map("n", "<leader>lg", "<cmd>LazyGit<RETURN>", { desc = "LazyGit Open Lazygit" })

-- Diagnostic keymaps
map("n", "<leader>qd", vim.diagnostic.setloclist, { desc = "Diagnostic Open [Q]uickfix [D]iagnostic list" })
-- map("n", "[d", vim.diagnostic.setloclist, { desc = "Diagnostic Jump to previous [D]iagnostic" })
-- map("n", "]d", vim.diagnostic.setloclist, { desc = "Diagnostic Jump to next [D]iagnostic" })

-- map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "MINE: Exit terminal mode" })

-- Shortcut for searching your Neovim configuration files
map("n", "<leader>sn", function()
    local builtin = require "telescope.builtin"
    builtin.find_files { cwd = vim.fn.stdpath "config" }
end, { desc = "[S]earch [N]eovim files" })

map("n", "<leader>e", "<Cmd>Neotree reveal<CR>", { desc = "Neotree: Reveal" })

-- Keep results centered while searching
map("n", "n", "nzzzv", { desc = "" })
map("n", "N", "Nzzzv", { desc = "" })

-- Keep cursor centered while scrolling with ctrl-d and ctrl-u
-- replaced with smooth scroll
-- map("n", "<C-u>", "<C-u>zz", { desc = "MINE: Scroll [U]p" })
-- map("n", "<C-d>", "<C-d>zz", { desc = "MINE: Scroll [D]own" })

-- Keep things highlighted when moving with < or >
map("v", "<", "<gv", { desc = "" })
map("v", ">", ">gv", { desc = "" })

-- Scroll Line by line with ctrl-n ctrl-p
map("n", "<C-n>", "<C-e>")
map("n", "<C-p>", "<C-y>")

map("n", "<leader>rr", ":luafile %<CR>")

-- If I visually select words and paste from clipboard, don't replace existing clip
map("x", "p", '"_dP')

-- quickfix list
map("n", "<leader>cn", ":cnext<cr>", { desc = "Quickfix: [C]uickfix [N]ext" })
map("n", "<leader>cp", ":cprev<cr>", { desc = "Quickfix: [C]uickfix [P]ext" })
map("n", "<leader>cc", ":cclose<cr>", { desc = "Quickfix: [C]uickfix [C]lose" })

-- Diffview
map("n", "<leader>dvo", ":DiffviewOpen<CR>", { desc = "Diffview: [D]iff[v]iew [O]pen" })
map("n", "<leader>dvO", ":DiffviewOpen HEAD~1<CR>", { desc = "Diffview: [D]iff[v]iew [O]pen HEAD" })
map("n", "<leader>dvc", ":DiffviewClose<CR>", { desc = "Diffview: [D]iff[v]iew [C]lose" })
map("n", "<leader>dvfh", ":DiffviewFileHistory %<CR>", { desc = "Diffview: [D]iff[v]iew [F]ile [H]istory %" })
map("n", "<leader>dvfH", ":DiffviewFileHistory<CR>", { desc = "Diffview: [D]iff[v]iew [F]ile [H]istory" })
map("n", "<C-\\>", ":DiffviewToggleFiles<CR>", { desc = "Diffview: Toggle files" })

-- Harpoon
local harpoon = require "harpoon"
map("n", "<M-a>", function()
    harpoon:list():add()
end)
map("n", "<M-e>", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
end)
map("n", "<M-h>", function()
    harpoon:list():select(1)
end)
map("n", "<M-j>", function()
    harpoon:list():select(2)
end)
map("n", "<M-k>", function()
    harpoon:list():select(3)
end)
map("n", "<M-l>", function()
    harpoon:list():select(4)
end)
map("n", "<M-;>", function()
    harpoon:list():select(5)
end)
