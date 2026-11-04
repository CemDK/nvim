-- Menu for a visual selection. The menu opens after visual mode was left, so each item reselects with gv first.
local join = require("configs.menus").join

local function on_selection(fn)
    return function()
        vim.cmd "normal! gv"
        fn()
    end
end

local function feed(keys, mode)
    vim.api.nvim_feedkeys(vim.keycode(keys), mode, false)
end

local function refactor(name)
    return function()
        -- refactoring.nvim actions return the g@ operator; apply it to the reselected range.
        feed("gv" .. require("refactoring")[name](), "nx")
    end
end

return function(ctx)
    local lsp = {}
    if #vim.lsp.get_clients { bufnr = ctx.buf } > 0 then
        lsp = {
            { name = "  Code action", cmd = on_selection(vim.lsp.buf.code_action), rtxt = "<leader>ca" },
        }
    end

    local edit = {
        { name = "󰊕  Extract function", cmd = refactor "extract_func" },
        { name = "󰫧  Extract variable", cmd = refactor "extract_var" },
        {
            name = "  Format selection",
            cmd = on_selection(function()
                require("conform").format { lsp_format = "fallback" }
            end),
        },
        {
            name = "  Toggle comment",
            cmd = function()
                feed("gvgc", "mx")
            end,
            rtxt = "<leader>/",
        },
    }

    local copy = {
        {
            name = "  Copy to clipboard",
            cmd = function()
                vim.cmd 'normal! gv"+y'
            end,
            rtxt = "<C-c>",
        },
    }

    return join(lsp, edit, copy)
end
