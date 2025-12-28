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
        "json",

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
    },

    auto_install = true,
    highlight = {
        enable = true,
        use_languagetree = true,
    },

    indent = {
        enable = true,
    },

    event = { "BufReadPost", "BufNewFile" },
    -- additional_vim_regex_highlighting = false,

    autopairs = { enable = true },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = { query = "@function.outer", desc = "around function" },
                ["if"] = { query = "@function.inner", desc = "inside function" },
                ["ab"] = { query = "@block.inner", desc = "around block" },
                ["ib"] = { query = "@block.inner", desc = "inside block" },
                -- ["ap"] = { query = "@parameter.outer", desc = "around parameter" },
                -- ["ip"] = { query = "@parameter.inner", desc = "inside a parameter" },
                ["ai"] = { query = "@conditional.outer", desc = "around an if statement" },
                ["ii"] = { query = "@conditional.inner", desc = "inside if statement" },
            },
            include_surrounding_whitespace = false,
        },
    },

    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = 2000,
    },

    autotag = {
        enable = true,
    },
}
