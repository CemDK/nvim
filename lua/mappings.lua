local map = function(mode, keys, func, desc)
    mode = mode or "n"
    vim.keymap.set(mode, keys, func, desc)
end

----------------------------------------
-- NVChad Mappings
----------------------------------------
-- tabufline
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "Tabufline buffer new" })
map("n", "<tab>", function()
    require("nvchad.tabufline").next()
end, { desc = "Tabufline Buffer goto next" })
map("n", "<S-tab>", function()
    require("nvchad.tabufline").prev()
end, { desc = "Tabufline buffer goto prev" })
map("n", "<leader>x", function()
    require("nvchad.tabufline").close_buffer()
end, { desc = "Tabufline buffer close" })
map("n", "<leader>th", function()
    require("nvchad.themes").open()
end, { desc = "telescope nvchad themes" })

-- terminal
map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })
map("t", "<ESC><ESC>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })
-- new terminals
map("n", "<leader>h", function()
    require("nvchad.term").new { pos = "sp" }
end, { desc = "terminal new horizontal term" })
map("n", "<leader>v", function()
    require("nvchad.term").new { pos = "vsp" }
end, { desc = "terminal new vertical term" })
-- toggleable
map({ "n", "t" }, "<A-v>", function()
    require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "terminal toggleable vertical term" })
map({ "n", "t" }, "<A-h>", function()
    require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal toggleable horizontal term" })
map({ "n", "t" }, "<A-i>", function()
    require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "terminal toggle floating term" })

-- whichkey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })
map("n", "<leader>wk", function()
    vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "whichkey query lookup" })

----------------------------------------
-- File Explorer
----------------------------------------
map("n", "<leader>e", "<Cmd>Neotree reveal<CR>", { desc = "Neotree: Reveal" })

----------------------------------------
-- Basic Editor Controls
----------------------------------------
-- Insert mode navigation
map("i", "jk", "<ESC>")
map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

-- Save operations
map({ "i", "n", "v" }, "<C-s>", "<ESC>:w<RETURN>", { desc = "Editor: Save and go to normal mode" })
map("n", "<leader>w", ":w<RETURN>", { desc = "Editor: [W]rite" })
map("n", "<leader>qq", ":wqa!<RETURN>", { desc = "Editor: [W]rite [A]ll and [Q]uit" })

-- Editor UI toggles
map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "toggle line number" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })
map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })

-- Selection
map("n", "<C-a>", "gg<S-v>G", { desc = "Editor: Select all" })

-- Copy/Paste operations
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general copy whole file" })
map("x", "p", '"_dP', { desc = "Editor: Paste without replacing clipboard" })

-- Navigation improvements
map("n", "n", "nzzzv", { desc = "Navigation: Keep search results centered (next)" })
map("n", "N", "Nzzzv", { desc = "Navigation: Keep search results centered (prev)" })
map("v", "<", "<gv", { desc = "Editor: Keep selection after indent left" })
map("v", ">", ">gv", { desc = "Editor: Keep selection after indent right" })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Editor: Move line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Editor: Move line up" })
map("n", "J", "mzJ`z", { desc = "Editor: Join lines" })
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

-- Scrolling
map("n", "<C-n>", "<C-e>", { desc = "Navigation: Scroll down one line" })
map("n", "<C-p>", "<C-y>", { desc = "Navigation: Scroll up one line" })

-- Comment
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- Format
map("n", "<leader>fm", function()
    require("conform").format { lsp_fallback = true }
end, { desc = "general format file" })

----------------------------------------
-- Window Management
----------------------------------------
map("n", "ss", ":split<RETURN>", { desc = "Window: [S]plit [S]creen" })
map("n", "sv", ":vsplit<RETURN>", { desc = "Window: [S]plit screen [V]ertically" })
map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

----------------------------------------
-- Lua Development
----------------------------------------
-- Execute current Lua file
map("n", "<leader>rr", ":luafile %<CR>", { desc = "Lua: Execute current file" })

----------------------------------------
-- Diagnostic & Quickfix
----------------------------------------
map("n", "<leader>dsll", vim.diagnostic.setloclist, { desc = "Diagnostic: [S]et [L]oc [L]ist" })
map("n", "<leader>dsqfl", vim.diagnostic.setqflist, { desc = "Diagnostic: [S]et [Q]uickfix [L]ist" })
map("n", "<leader>dof", vim.diagnostic.open_float, { desc = "Diagnostic: [O]pen [F]loat" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Diagnostic: Jump to previous" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Diagnostic: Jump to next" })

-- Quickfix navigation
map("n", "<leader>cn", vim.diagnostic.goto_next, { desc = "Quickfix: [N]ext" })
map("n", "<leader>cp", vim.diagnostic.goto_prev, { desc = "Quickfix: [P]revious" })
map("n", "<leader>cc", ":cclose<cr>", { desc = "Quickfix: [C]lose" })

----------------------------------------
-- Git Integration
----------------------------------------
-- LazyGit
map("n", "<leader>lg", "<cmd>LazyGit<RETURN>", { desc = "LazyGit: Open Lazygit" })

-- Diffview
map("n", "<leader>dvo", ":DiffviewOpen<CR>", { desc = "Diffview: [O]pen" })
map("n", "<leader>dvO", ":DiffviewOpen HEAD~1<CR>", { desc = "Diffview: [O]pen HEAD" })
map("n", "<leader>dvc", ":DiffviewClose<CR>", { desc = "Diffview: [C]lose" })
map("n", "<leader>dvfh", ":DiffviewFileHistory %<CR>", { desc = "Diffview: [F]ile [H]istory %" })
map("n", "<leader>dvfH", ":DiffviewFileHistory<CR>", { desc = "Diffview: [F]ile [H]istory" })
map("n", "<C-\\>", ":DiffviewToggleFiles<CR>", { desc = "Diffview: Toggle files" })

-- Snacks Git Integration
local Snacks = require "snacks"
map("n", "<leader>gb", function()
    Snacks.picker.git_branches()
end, { desc = "Git Branches" })

map("n", "<leader>gl", function()
    Snacks.picker.git_log()
end, { desc = "Git Log" })

map("n", "<leader>gL", function()
    Snacks.picker.git_log_line()
end, { desc = "Git Log Line" })

map("n", "<leader>gs", function()
    Snacks.picker.git_status()
end, { desc = "Git Status" })

map("n", "<leader>gS", function()
    Snacks.picker.git_stash()
end, { desc = "Git Stash" })

map("n", "<leader>gd", function()
    Snacks.picker.git_diff()
end, { desc = "Git Diff (Hunks)" })

map("n", "<leader>gf", function()
    Snacks.picker.git_log_file()
end, { desc = "Git Log File" })

----------------------------------------
-- Telescope
----------------------------------------
local telescope = require "telescope.builtin"
map("n", "<leader>sn", function()
    telescope.find_files { cwd = vim.fn.stdpath "config" }
end, { desc = "Telescope: [S]earch [N]eovim files" })

map("n", "<leader>fg", function()
    telescope.live_grep()
end, { desc = "Telescope: [F]ind [G]rep" })

map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })
map(
    "n",
    "<leader>fa",
    "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
    { desc = "telescope find all files" }
)

----------------------------------------
-- Harpoon
----------------------------------------
local harpoon = require "harpoon"
map("n", "<M-a>", function()
    harpoon:list():add()
end, { desc = "Harpoon: Add file" })
map("n", "<M-e>", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon: Toggle quick menu" })
map("n", "<M-h>", function()
    harpoon:list():select(1)
end, { desc = "Harpoon: Select file 1" })
map("n", "<M-j>", function()
    harpoon:list():select(2)
end, { desc = "Harpoon: Select file 2" })
map("n", "<M-k>", function()
    harpoon:list():select(3)
end, { desc = "Harpoon: Select file 3" })
map("n", "<M-l>", function()
    harpoon:list():select(4)
end, { desc = "Harpoon: Select file 4" })
map("n", "<M-;>", function()
    harpoon:list():select(5)
end, { desc = "Harpoon: Select file 5" })

----------------------------------------
-- Context Menus
----------------------------------------
-- Right Click Menu
map({ "n", "v" }, "<RightMouse>", function()
    require("menu.utils").delete_old_menus()

    vim.cmd.exec '"normal! \\<RightMouse>"'

    -- clicked buf
    local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
    local options = vim.bo[buf].ft == "neo-tree" and require "configs.menu-neo-tree" or "default"
    print(vim.bo[buf].ft)

    require("menu").open(options, { mouse = true })
end, { desc = "Menu: Open right click menu" })

----------------------------------------
-- Copilot Chat
----------------------------------------
local chat = require "CopilotChat"
local window = require("CopilotChat").chat
map({ "n", "v" }, "<leader>aa", function()
    if window:visible() and not window:focused() then
        window:focus()
        window:follow()
    elseif window:visible() and window:focused() then
        chat.close()
    else
        chat.toggle()
    end
end, { desc = "CopilotChat: Toggle" })

map({ "n", "v" }, "<leader>ax", function()
    return require("CopilotChat").reset()
end, { desc = "CopilotChat: Clear" })

map({ "n", "v" }, "<leader>aq", function()
    vim.ui.input({
        prompt = "Quick Chat: ",
    }, function(input)
        if input ~= "" then
            require("CopilotChat").ask(input)
        end
    end)
end, { desc = "CopilotChat: Quick Chat" })

map({ "n", "v" }, "<leader>ap", function()
    require("CopilotChat").select_prompt()
end, { desc = "CopilotChat: Prompt Actions" })

map("n", "<leader>as", function()
    require("CopilotChat").save(vim.fn.input "Save as: ")
end, { desc = "CopilotChat: [S]ave Chat" })

map("n", "<leader>al", function()
    require("CopilotChat").load(vim.fn.input "Load: ")
end, { desc = "CopilotChat: [L]oad Chat" })

----------------------------------------
-- Snacks mappings
----------------------------------------
map("n", "<leader>snh", function()
    Snacks.notifier.show_history()
end, { desc = "Show Notifier History" })

-- Top Pickers & Explorer
-- map("n", "<leader><space>", function() Snacks.picker.smart() end, {desc = "Smart Find Files" })
-- map("n", "<leader>,", function() Snacks.picker.buffers() end, {desc = "Buffers" })
-- map("n", "<leader>/", function() Snacks.picker.grep() end, {desc = "Grep" })
-- map("n", "<leader>:", function() Snacks.picker.command_history() end, {desc = "Command History" })
-- map("n", "<leader>n", function() Snacks.picker.notifications() end, {desc = "Notification History" })
-- map("n", "<leader>e", function() Snacks.explorer() end, {desc = "File Explorer" })
-- find
-- map("n", "<leader>fb", function() Snacks.picker.buffers() end, {desc = "Buffers" })
-- map("n", "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, {desc = "Find Config File" })
-- map("n", "<leader>ff", function() Snacks.picker.files() end, {desc = "Find Files" })
-- map("n", "<leader>fg", function() Snacks.picker.git_files() end, {desc = "Find Git Files" })
-- map("n", "<leader>fp", function() Snacks.picker.projects() end, {desc = "Projects" })
-- map("n", "<leader>fr", function() Snacks.picker.recent() end, {desc = "Recent" })
-- Grep
-- map("n", "<leader>sb", function() Snacks.picker.lines() end, {desc = "Buffer Lines" })
-- map("n", "<leader>sB", function() Snacks.picker.grep_buffers() end, {desc = "Grep Open Buffers" })
-- map("n", "<leader>sg", function() Snacks.picker.grep() end, {desc = "Grep" })
-- map("n", "<leader>sw", function() Snacks.picker.grep_word() end, {desc = "Visual selection or word", mode = { "n", "x" } })
-- search
-- map("n", '<leader>s"', function() Snacks.picker.registers() end, {desc = "Registers" })
-- map("n", '<leader>s/', function() Snacks.picker.search_history() end, {desc = "Search History" })
-- map("n", "<leader>sa", function() Snacks.picker.autocmds() end, {desc = "Autocmds" })
-- map("n", "<leader>sb", function() Snacks.picker.lines() end, {desc = "Buffer Lines" })
-- map("n", "<leader>sc", function() Snacks.picker.command_history() end, {desc = "Command History" })
-- map("n", "<leader>sC", function() Snacks.picker.commands() end, {desc = "Commands" })
-- map("n", "<leader>sd", function() Snacks.picker.diagnostics() end, {desc = "Diagnostics" })
-- map("n", "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, {desc = "Buffer Diagnostics" })
-- map("n", "<leader>sh", function() Snacks.picker.help() end, {desc = "Help Pages" })
-- map("n", "<leader>sH", function() Snacks.picker.highlights() end, {desc = "Highlights" })
-- map("n", "<leader>si", function() Snacks.picker.icons() end, {desc = "Icons" })
-- map("n", "<leader>sj", function() Snacks.picker.jumps() end, {desc = "Jumps" })
-- map("n", "<leader>sk", function() Snacks.picker.keymaps() end, {desc = "Keymaps" })
-- map("n", "<leader>sl", function() Snacks.picker.loclist() end, {desc = "Location List" })
-- map("n", "<leader>sm", function() Snacks.picker.marks() end, {desc = "Marks" })
-- map("n", "<leader>sM", function() Snacks.picker.man() end, {desc = "Man Pages" })
-- map("n", "<leader>sp", function() Snacks.picker.lazy() end, {desc = "Search for Plugin Spec" })
-- map("n", "<leader>sq", function() Snacks.picker.qflist() end, {desc = "Quickfix List" })
-- map("n", "<leader>sR", function() Snacks.picker.resume() end, {desc = "Resume" })
-- map("n", "<leader>su", function() Snacks.picker.undo() end, {desc = "Undo History" })
-- map("n", "<leader>uC", function() Snacks.picker.colorschemes() end, {desc = "Colorschemes" })
-- Other
-- map("n", "<leader>z",  function() Snacks.zen() end, {desc = "Toggle Zen Mode" })
-- map("n", "<leader>Z",  function() Snacks.zen.zoom() end, {desc = "Toggle Zoom" })
-- map("n", "<leader>.",  function() Snacks.scratch() end, {desc = "Toggle Scratch Buffer" })
-- map("n", "<leader>S",  function() Snacks.scratch.select() end, {desc = "Select Scratch Buffer" })
-- map("n", "<leader>n",  function() Snacks.notifier.show_history() end, {desc = "Notification History" })
-- map("n", "<leader>bd", function() Snacks.bufdelete() end, {desc = "Delete Buffer" })
-- map("n", "<leader>cR", function() Snacks.rename.rename_file() end, {desc = "Rename File" })
-- map("n", "<leader>gB", function() Snacks.gitbrowse() end, {desc = "Git Browse", mode = { "n", "v" } })
-- map("n", "<leader>gg", function() Snacks.lazygit() end, {desc = "Lazygit" })
-- map("n", "<leader>un", function() Snacks.notifier.hide() end, {desc = "Dismiss All Notifications" })
-- map("n", "<c-/>",      function() Snacks.terminal() end, {desc = "Toggle Terminal" })
-- map("n", "<c-_>",      function() Snacks.terminal() end, {desc = "which_key_ignore" })
-- map("n", "]]",         function() Snacks.words.jump(vim.v.count1) end, {desc = "Next Reference", mode = { "n", "t" } })
-- map("n", "[[",         function() Snacks.words.jump(-vim.v.count1) end, {desc = "Prev Reference", mode = { "n", "t" } })
-- map("n", "<leader>N", {desc = "Neovim News", function() Snacks.win({ file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1], width = 0.6, height = 0.6, wo = { spell = false, wrap = false, signcolumn = "yes", statuscolumn = " ", conceallevel = 3, }, }) end, } })
-- map("n", "<leader>Z",  function() Snacks.zen.zoom() end, {desc = "Toggle Zoom" })
-- map("n", "<leader>.",  function() Snacks.scratch() end, {desc = "Toggle Scratch Buffer" })
-- map("n", "<leader>S",  function() Snacks.scratch.select() end, {desc = "Select Scratch Buffer" })
-- map("n", "<leader>n",  function() Snacks.notifier.show_history() end, {desc = "Notification History" })
-- map("n", "<leader>bd", function() Snacks.bufdelete() end, {desc = "Delete Buffer" })
-- map("n", "<leader>cR", function() Snacks.rename.rename_file() end, {desc = "Rename File" })
-- map("n", "<leader>gB", function() Snacks.gitbrowse() end, {desc = "Git Browse", mode = { "n", "v" } })
-- map("n", "<leader>gg", function() Snacks.lazygit() end, {desc = "Lazygit" })
-- map("n", "<leader>un", function() Snacks.notifier.hide() end, {desc = "Dismiss All Notifications" })
-- map("n", "<c-/>",      function() Snacks.terminal() end, {desc = "Toggle Terminal" })
-- map("n", "<c-_>",      function() Snacks.terminal() end, {desc = "which_key_ignore" })
-- map("n", "]]",         function() Snacks.words.jump(vim.v.count1) end, {desc = "Next Reference", mode = { "n", "t" } })
-- map("n", "[[",         function() Snacks.words.jump(-vim.v.count1) end, {desc = "Prev Reference", mode = { "n", "t" } })
-- map("n", "<leader>N", {desc = "Neovim News", function() Snacks.win({ file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1], width = 0.6, height = 0.6, wo = { spell = false, wrap = false, signcolumn = "yes", statuscolumn = " ", conceallevel = 3, }, }) end, } })
