-- Menu for neo-tree windows. Actions run against the state of the clicked window, so the filesystem tree and
-- the edgy Git Status panel each act on their own nodes.
local join = require("configs.menus").join
local manager = require "neo-tree.sources.manager"

local function state_of(ctx)
    local state = manager.get_state_for_window(ctx.win)
    if state then
        state.config = state.config or {}
    end
    return state
end

-- Call a neo-tree command by name; source modules include the common commands.
local function call(name)
    return function(ctx)
        local state = state_of(ctx)
        if not state then
            return
        end
        local commands = require("neo-tree.sources." .. state.name .. ".commands")
        commands[name](state)
    end
end

local function node_of(ctx)
    local state = state_of(ctx)
    local node = state and state.tree and state.tree:get_node()
    if not node or node.type == "message" then
        return nil
    end
    return node
end

local function copy_path(modifier)
    return function(ctx)
        local node = node_of(ctx)
        if node then
            local path = vim.fn.fnamemodify(node.path, modifier)
            vim.fn.setreg("+", path)
            vim.notify("Copied: " .. path)
        end
    end
end

local function open_terminal(ctx)
    local node = node_of(ctx)
    if not node then
        return
    end
    local dir = node.type == "directory" and node.path or vim.fn.fnamemodify(node.path, ":h")
    require("nvchad.term").new { pos = "sp", cmd = "cd " .. vim.fn.shellescape(dir) }
end

-- Keys match the window mappings in configs/neo-tree.lua.
local open = {
    { name = "  Open", cmd = call "open" },
    { name = "  Open in vertical split", cmd = call "open_vsplit", rtxt = "s" },
    { name = "  Open in horizontal split", cmd = call "open_split", rtxt = "S" },
    { name = "󰓪  Open in new tab", cmd = call "open_tabnew", rtxt = "t" },
}

local paths = {
    { name = "  Copy relative path", cmd = copy_path ":~:." },
    { name = "󰴠  Copy absolute path", cmd = copy_path ":p" },
}

local by_source = {
    filesystem = function()
        return join(
            open,
            {
                { name = "  New file", cmd = call "add", rtxt = "a" },
                { name = "  New folder", cmd = call "add_directory", rtxt = "A" },
            },
            {
                { name = "  Copy", cmd = call "copy_to_clipboard", rtxt = "y" },
                { name = "  Cut", cmd = call "cut_to_clipboard", rtxt = "x" },
                { name = "  Paste", cmd = call "paste_from_clipboard", rtxt = "p" },
                { name = "  Copy to…", cmd = call "copy", rtxt = "c" },
                { name = "  Move to…", cmd = call "move", rtxt = "m" },
                { name = "  Rename", cmd = call "rename", rtxt = "r" },
                { name = "  Delete", cmd = call "delete", rtxt = "d", hl = "ExRed" },
            },
            paths,
            {
                { name = "  Open terminal here", cmd = open_terminal },
                { name = "  Toggle hidden files", cmd = call "toggle_hidden", rtxt = "H" },
            }
        )
    end,

    git_status = function()
        return join({ open[1], open[2], open[3] }, {
            { name = "  Stage file", cmd = call "git_add_file", rtxt = "ga" },
            { name = "  Unstage file", cmd = call "git_unstage_file", rtxt = "gu" },
            { name = "  Stage all", cmd = call "git_add_all", rtxt = "A" },
            { name = "  Revert file", cmd = call "git_revert_file", rtxt = "gr", hl = "ExRed" },
        }, {
            { name = "  Commit", cmd = call "git_commit", rtxt = "gc" },
            { name = "  Push", cmd = call "git_push", rtxt = "gp" },
        }, paths)
    end,

    buffers = function()
        return join({ open[1], open[2], open[3] }, {
            { name = "  Close buffer", cmd = call "buffer_delete", rtxt = "d", hl = "ExRed" },
        }, paths)
    end,
}

return function(ctx)
    local state = state_of(ctx)
    local build = state and by_source[state.name]
    return build and build() or nil
end
