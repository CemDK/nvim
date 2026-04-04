pcall(function()
    dofile(vim.g.base46_cache .. "syntax")
    dofile(vim.g.base46_cache .. "treesitter")
end)

-- nvim-treesitter main branch: only handles parser installation
-- highlight, indent, etc. are now built into neovim 0.12+
require("nvim-treesitter").setup({})

-- Enable treesitter highlighting and indentation for every buffer
vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        local ok = pcall(vim.treesitter.start, args.buf)
        if ok then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
    end,
})

-- Install parsers
local parsers = {
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "json",

    "c_sharp",

    "markdown",
    "markdown_inline",
    "printf",
    "query",
    "regex",
    "vim",
    "vimdoc",
    "yaml",

    "go",
    "gomod",
    "gowork",
    "gosum",

    "bash",
    "lua",
    "luadoc",
    "python",
    "rust",
    "terraform",
}

-- Auto-install missing parsers
local installed = require("nvim-treesitter").get_installed()
local installed_set = {}
for _, p in ipairs(installed) do
    installed_set[p] = true
end

local to_install = {}
for _, p in ipairs(parsers) do
    if not installed_set[p] then
        table.insert(to_install, p)
    end
end

if #to_install > 0 then
    require("nvim-treesitter").install(to_install)
end

-- Textobjects
require("nvim-treesitter-textobjects").setup({
    select = {
        lookahead = true,
        include_surrounding_whitespace = false,
    },
})

local select = require("nvim-treesitter-textobjects.select")
local mode = { "x", "o" }

vim.keymap.set(mode, "af", function()
    select.select_textobject("@function.outer", "textobjects")
end, { desc = "around function" })
vim.keymap.set(mode, "if", function()
    select.select_textobject("@function.inner", "textobjects")
end, { desc = "inside function" })
vim.keymap.set(mode, "ab", function()
    select.select_textobject("@block.outer", "textobjects")
end, { desc = "around block" })
vim.keymap.set(mode, "ib", function()
    select.select_textobject("@block.inner", "textobjects")
end, { desc = "inside block" })
vim.keymap.set(mode, "ai", function()
    select.select_textobject("@conditional.outer", "textobjects")
end, { desc = "around if statement" })
vim.keymap.set(mode, "ii", function()
    select.select_textobject("@conditional.inner", "textobjects")
end, { desc = "inside if statement" })
