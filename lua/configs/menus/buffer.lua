-- Normal-mode menu for file buffers.
local join = require("configs.menus").join

local function filetype_section(ctx)
    local by_ft = {
        markdown = {
            { name = "  Toggle Markview", cmd = "Markview toggle" },
        },
        tex = {
            { name = "  Compile (toggle)", cmd = "VimtexCompile", rtxt = "\\ll" },
            { name = "  View PDF", cmd = "VimtexView", rtxt = "\\lv" },
            { name = "  Table of contents", cmd = "VimtexTocToggle", rtxt = "\\lt" },
            { name = "  Clean aux files", cmd = "VimtexClean", rtxt = "\\lc" },
        },
    }
    return by_ft[ctx.ft]
end

local function lsp_section(ctx)
    if #vim.lsp.get_clients { bufnr = ctx.buf } == 0 then
        return nil
    end
    local tb = function(name)
        return function()
            require("telescope.builtin")[name]()
        end
    end
    return {
        { name = "  Code action", cmd = vim.lsp.buf.code_action, rtxt = "<leader>ca" },
        { name = "  Rename symbol", cmd = vim.lsp.buf.rename, rtxt = "<leader>rn" },
        { name = "  Go to definition", cmd = tb "lsp_definitions", rtxt = "gd" },
        { name = "  Go to references", cmd = tb "lsp_references", rtxt = "gr" },
        { name = "  Go to implementation", cmd = tb "lsp_implementations", rtxt = "gI" },
        { name = "  Type definition", cmd = tb "lsp_type_definitions", rtxt = "<leader>D" },
        { name = "  Hover docs", cmd = vim.lsp.buf.hover, rtxt = "K" },
    }
end

local function diagnostics_section(ctx)
    if #vim.diagnostic.get(ctx.buf) == 0 then
        return nil
    end
    local items = {}
    if #vim.diagnostic.get(ctx.buf, { lnum = ctx.cursor[1] - 1 }) > 0 then
        table.insert(items, { name = "  Line diagnostics", cmd = vim.diagnostic.open_float, rtxt = "<leader>cd" })
    end
    table.insert(items, {
        name = "  Buffer diagnostics",
        cmd = "Trouble diagnostics toggle filter.buf=0",
        rtxt = "<leader>Tb",
    })
    return items
end

local function cursor_on_hunk(ctx)
    local ok, hunks = pcall(require("gitsigns").get_hunks, ctx.buf)
    if not ok or not hunks then
        return false
    end
    local line = ctx.cursor[1]
    for _, h in ipairs(hunks) do
        local first = h.added.start
        local last = first + math.max(h.added.count, 1) - 1
        if line >= first and line <= last then
            return true
        end
    end
    return false
end

local function git_section(ctx)
    if not vim.b[ctx.buf].gitsigns_head then
        return nil
    end
    local gs = function(name, ...)
        local args = { ... }
        return function()
            require("gitsigns")[name](unpack(args))
        end
    end

    local hunk = {}
    if cursor_on_hunk(ctx) then
        hunk = {
            { name = "  Stage / unstage hunk", cmd = gs "stage_hunk" },
            { name = "  Preview hunk", cmd = gs "preview_hunk_inline" },
            { name = "  Reset hunk", cmd = gs "reset_hunk", hl = "ExRed" },
        }
    end
    local file = {
        { name = "  Blame line", cmd = gs("blame_line", { full = true }) },
        { name = "  Diff against index", cmd = gs "diffthis" },
        { name = "  File history", cmd = "DiffviewFileHistory %", rtxt = "<leader>dvf" },
        {
            name = "  Line history",
            cmd = function()
                Snacks.picker.git_log_line()
            end,
            rtxt = "<leader>gL",
        },
        { name = "  Stage buffer", cmd = gs "stage_buffer" },
    }
    return {
        { name = "  Git", hl = "ExBlue", items = join(hunk, file) },
    }
end

local function general_section(ctx)
    return {
        {
            name = "  Format buffer",
            cmd = function()
                require("conform").format { lsp_format = "fallback" }
            end,
            rtxt = "<leader>ofm",
        },
        { name = "  Copy buffer", cmd = "%y+", rtxt = "<C-c>" },
        {
            name = "  Copy relative path",
            cmd = function()
                local path = vim.fn.expand "%:~:."
                vim.fn.setreg("+", path)
                vim.notify("Copied: " .. path)
            end,
        },
        {
            name = "  Open terminal here",
            cmd = function()
                local dir = vim.fn.expand "%:p:h"
                require("nvchad.term").new { pos = "sp", cmd = "cd " .. vim.fn.shellescape(dir) }
            end,
        },
        { name = "  Color picker", cmd = "Huefy" },
    }
end

return function(ctx)
    return join(
        filetype_section(ctx),
        lsp_section(ctx),
        diagnostics_section(ctx),
        git_section(ctx),
        general_section(ctx)
    )
end
