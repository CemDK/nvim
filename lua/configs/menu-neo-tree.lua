local function get_state()
    local manager = require "neo-tree.sources.manager"
    local state = manager.get_state "filesystem"

    -- Fix: Ensure state has config.
    -- Sometimes state is returned without config if not fully initialized or if accessed from a different context.
    if state and not state.config then
        local nt = require "neo-tree"
        -- Try to grab the config from the global setup if missing in state
        if nt.config and nt.config.filesystem then
            state.config = nt.config.filesystem
        end
    end
    return state
end

local function get_focused_node()
    local state = get_state()
    if state and state.tree then
        return state.tree:get_node()
    end
    return nil
end

local fs_commands = require "neo-tree.sources.filesystem.commands"
local common_commands = require "neo-tree.sources.common.commands"

-- Helper to execute commands safely
local function exec(cmd_func)
    return function()
        local state = get_state()
        if state and state.config then
            cmd_func(state)
        else
            vim.notify("Neo-tree state not ready", vim.log.levels.WARN)
        end
    end
end

return {
    {
        name = "  New file",
        cmd = exec(fs_commands.add),
        rtxt = "a",
    },
    {
        name = "  New folder",
        cmd = exec(fs_commands.add_directory),
        rtxt = "A",
    },
    { name = "separator" },
    {
        name = "  Open in window",
        cmd = exec(common_commands.open),
        rtxt = "o",
    },
    {
        name = "  Open in vertical split",
        cmd = exec(common_commands.open_vsplit),
        rtxt = "v",
    },
    {
        name = "  Open in horizontal split",
        cmd = exec(common_commands.open_split),
        rtxt = "s",
    },
    {
        name = "󰓪  Open in new tab",
        cmd = exec(common_commands.open_tabnew),
        rtxt = "O",
    },
    { name = "separator" },
    {
        name = "  Cut",
        cmd = exec(fs_commands.cut_to_clipboard),
        rtxt = "x",
    },
    {
        name = "  Paste",
        cmd = exec(fs_commands.paste_from_clipboard),
        rtxt = "p",
    },
    {
        name = "  Copy",
        cmd = exec(fs_commands.copy_to_clipboard),
        rtxt = "c",
    },
    {
        name = "󰴠  Copy absolute path",
        cmd = function()
            local node = get_focused_node()
            if node then
                vim.fn.setreg("+", node.path)
                vim.notify("Copied: " .. node.path)
            end
        end,
        rtxt = "gy",
    },
    {
        name = "  Copy relative path",
        cmd = function()
            local node = get_focused_node()
            if node then
                local relative_path = vim.fn.fnamemodify(node.path, ":.")
                vim.fn.setreg("+", relative_path)
                vim.notify("Copied: " .. relative_path)
            end
        end,
        rtxt = "Y",
    },
    { name = "separator" },
    {
        name = "  Rename",
        cmd = exec(fs_commands.rename),
        rtxt = "r",
    },
    {
        name = "  Trash",
        cmd = exec(fs_commands.delete),
        rtxt = "D",
    },
    {
        name = "  Delete",
        hl = "ExRed",
        cmd = exec(fs_commands.delete),
        rtxt = "d",
    },
}
