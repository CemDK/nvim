local function get_focused_node()
    return require("neo-tree.sources.manager").get_current_source().tree:get_node()
end

return {

    {
        name = "  New file",
        cmd = function()
            local node = get_focused_node()
            vim.api.nvim_exec("Neotree action=add", false)
        end,
        rtxt = "a",
    },

    {
        name = "  New folder",
        cmd = function()
            local node = get_focused_node()
            vim.api.nvim_exec("Neotree action=add_directory", false)
        end,
        rtxt = "a", -- Same key as for creating a new file or directory
    },

    { name = "separator" },

    {
        name = "  Open in window",
        cmd = function()
            local node = get_focused_node()
            vim.api.nvim_exec("Neotree action=open", false)
        end,
        rtxt = "o",
    },

    {
        name = "  Open in vertical split",
        cmd = function()
            local node = get_focused_node()
            vim.api.nvim_exec("Neotree action=open_vsplit", false)
        end,
        rtxt = "v",
    },

    {
        name = "  Open in horizontal split",
        cmd = function()
            local node = get_focused_node()
            vim.api.nvim_exec("Neotree action=open_split", false)
        end,
        rtxt = "s",
    },

    {
        name = "󰓪  Open in new tab",
        cmd = function()
            local node = get_focused_node()
            vim.api.nvim_exec("Neotree action=open_tabnew", false)
        end,
        rtxt = "O",
    },

    { name = "separator" },

    {
        name = "  Cut",
        cmd = function()
            local node = get_focused_node()
            vim.api.nvim_exec("Neotree action=cut", false)
        end,
        rtxt = "x",
    },

    {
        name = "  Paste",
        cmd = function()
            local node = get_focused_node()
            vim.api.nvim_exec("Neotree action=paste", false)
        end,
        rtxt = "p",
    },

    {
        name = "  Copy",
        cmd = function()
            local node = get_focused_node()
            vim.api.nvim_exec("Neotree action=copy", false)
        end,
        rtxt = "c",
    },

    {
        name = "󰴠  Copy absolute path",
        cmd = function()
            local node = get_focused_node()
            vim.fn.setreg("+", node.path)
        end,
        rtxt = "gy",
    },

    {
        name = "  Copy relative path",
        cmd = function()
            local node = get_focused_node()
            local relative_path = vim.fn.fnamemodify(node.path, ":.")
            vim.fn.setreg("+", relative_path)
        end,
        rtxt = "Y",
    },

    { name = "separator" },

    {
        name = "  Open in terminal",
        hl = "ExBlue",
        cmd = function()
            local node = get_focused_node()
            local path = node.path
            local is_directory = node.type == "directory"
            local dir = is_directory and path or vim.fn.fnamemodify(path, ":h")

            vim.cmd "enew"
            vim.fn.termopen { vim.o.shell, "-c", "cd " .. dir .. " ; " .. vim.o.shell }
        end,
    },

    { name = "separator" },

    {
        name = "  Rename",
        cmd = function()
            local node = get_focused_node()
            vim.api.nvim_exec("Neotree action=rename", false)
        end,
        rtxt = "r",
    },

    {
        name = "  Trash",
        cmd = function()
            local node = get_focused_node()
            vim.api.nvim_exec("Neotree action=trash", false)
        end,
        rtxt = "D",
    },

    {
        name = "  Delete",
        hl = "ExRed",
        cmd = function()
            local node = get_focused_node()
            vim.api.nvim_exec("Neotree action=delete", false)
        end,
        rtxt = "d",
    },
}
