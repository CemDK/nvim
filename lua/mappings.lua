require "nvchad.mappings"

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Control S to save and enter normal mode
map({ "i", "n", "v" }, "<C-s>", "<ESC>:w<Return>", { desc = "MINE: Save and go to normal mode" })

-- Select all
map("n", "<C-a>", "gg<S-v>G", { desc = "MINE: Select all" })

-- Save file and quit
map("n", "<leader>w", ":update<return>", { desc = "MINE: [W]rite" })
map("n", "<leader>qq", ":wqa<return>", { desc = "MINE: [W]rite [A]ll and [Q]uit" })

-- Split window
map("n", "ss", ":split<return>", { desc = "MINE: [S]lit [S]creen" })
map("n", "sv", ":vsplit<return>", { desc = "MINE: [S]lit screen [V]ertically" })

-- LazyGit
map("n", "<leader>lg", "<cmd>LazyGit<return>", { desc = "LazyGit Open Lazygit" })

-- Diagnostic keymaps
map("n", "<leader>qd", vim.diagnostic.setloclist, { desc = "Diagnostic Open [Q]uickfix [D]iagnostic list" })
-- map("n", "[d", vim.diagnostic.setloclist, { desc = "Diagnostic Jump to previous [D]iagnostic" })
-- map("n", "]d", vim.diagnostic.setloclist, { desc = "Diagnostic Jump to next [D]iagnostic" })

-- map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "MINE: Exit terminal mode" })

-- Mini map
local MiniMap = require "mini.map"
map("n", "<leader>mc", MiniMap.close, { desc = "MiniMap: [C]lose" })
map("n", "<leader>mf", MiniMap.toggle_focus, { desc = "MiniMap: [T]oggle focus" })
map("n", "<leader>mo", MiniMap.open, { desc = "MiniMap: [O]pen" })
map("n", "<leader>mr", MiniMap.refresh, { desc = "MiniMap: [R]efresh" })
map("n", "<leader>mss", MiniMap.toggle_side, { desc = "MiniMap: [S]wap [S]ide" })
map("n", "<leader>mt", MiniMap.toggle, { desc = "MiniMap: [T]oggle" })

-- Shortcut for searching your Neovim configuration files
map("n", "<leader>sn", function()
    local builtin = require "telescope.builtin"
    builtin.find_files { cwd = vim.fn.stdpath "config" }
end, { desc = "[S]earch [N]eovim files" })

map("n", "<leader>e", "<Cmd>Neotree reveal<CR>", { desc = "Neotree: Reveal" })

-- Keep results centered while searching
map("n", "n", "nzzzv", { desc = "" })
map("n", "N", "Nzzzv", { desc = "" })
-- Keep things highlighted when moving with < or >
map("v", "<", "<gv", { desc = "" })
map("v", ">", ">gv", { desc = "" })

-- Completion
