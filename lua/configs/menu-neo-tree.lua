local function get_state()
    return require("neo-tree.sources.manager").get_state("filesystem")
end

local function get_focused_node()
    local state = get_state()
    if state.tree then
        return state.tree:get_node()
    end
    return nil
end

local fs_commands = require "neo-tree.sources.filesystem.commands"
local common_commands = require "neo-tree.sources.common.commands"

return {
    {
        name = "  New file",
        cmd = function()
            fs_commands.add(get_state())
        end,
        rtxt = "a",
    },
    {
        name = "  New folder",
        cmd = function()
            fs_commands.add_directory(get_state())
        end,
        rtxt = "A",
    },
    { name = "separator" },
    {
        name = "  Open in window",
        cmd = function()
            common_commands.open(get_state())
        end,
        rtxt = "o",
    },
    {
        name = "  Open in vertical split",
        cmd = function()
            common_commands.open_vsplit(get_state())
        end,
        rtxt = "v",
    },
    {
        name = "  Open in horizontal split",
        cmd = function()
            common_commands.open_split(get_state())
        end,
        rtxt = "s",
    },
    {
        name = "󰓪  Open in new tab",
        cmd = function()
            common_commands.open_tabnew(get_state())
        end,
        rtxt = "O",
    },
    { name = "separator" },
    {
        name = "  Cut",
        cmd = function()
            fs_commands.cut_to_clipboard(get_state())
        end,
        rtxt = "x",
    },
    {
        name = "  Paste",
        cmd = function()
            fs_commands.paste_from_clipboard(get_state())
        end,
        rtxt = "p",
    },
    {
        name = "  Copy",
        cmd = function()
            fs_commands.copy_to_clipboard(get_state())
        end,
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
        name = "  Open in terminal",
        hl = "ExBlue",
        cmd = function()
            local node = get_focused_node()
            if not node then return end
            local path = node.path
            local is_directory = node.type == "directory"
            local dir = is_directory and path or vim.fn.fnamemodify(path, ":h")

            -- Try to use NvChad's terminal if available, otherwise fallback
            if package.loaded["nvchad.term"] then
                require("nvchad.term").new { pos = "sp", cwd = dir }
            else
                vim.cmd("split")
                vim.cmd("lcd " .. dir)
                vim.cmd("term")
            end
        end,
    },
    { name = "separator" },
    {
        name = "  Rename",
        cmd = function()
            fs_commands.rename(get_state())
        end,
        rtxt = "r",
    },
    {
        name = "  Trash",
        cmd = function()
            fs_commands.delete(get_state())
        end,
        rtxt = "D",
    },
    {
        name = "  Delete",
        hl = "ExRed",
        cmd = function()
            fs_commands.delete(get_state())
        end,
        rtxt = "d",
    },
}
