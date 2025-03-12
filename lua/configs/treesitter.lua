pcall(function()
    dofile(vim.g.base46_cache .. "syntax")
    dofile(vim.g.base46_cache .. "treesitter")
end)

return {
    ensure_installed = {
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "bash",
        "json",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "printf",
        "python",
        "query",
        "regex",
        "vim",
        "vimdoc",
        "yaml",
    },
    auto_install = true,
    highlight = {
        enable = true,
        use_languatree = true,
    },

    indent = {
        enable = true,
    },

    event = { "BufReadPost", "BufNewFile" },
    -- additional_vim_regex_highlighting = false,
}
