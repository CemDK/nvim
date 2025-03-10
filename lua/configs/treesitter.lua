return {
    ensure_installed = {
        "vim",
        "vimdoc",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "bash",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "yaml",
    },
    auto_install = true,
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    },
    event = { "BufReadPost", "BufNewFile" },
    opts = function(_, opts)
        vim.list_extend(opts.ensure_installed, {
            -- "tsx",
            -- "typescript",
            -- "javascript",
        })
        -- vim.api.nvim_set_hl(0, "@tag.tsx", { link = "Type" })
        -- vim.api.nvim_set_hl(0, "@tag.builtin.tsx", { link = "Variable" })
        -- vim.api.nvim_set_hl(0, "@variable.typescript", { link = "Type" })
        -- vim.api.nvim_set_hl(0, "@include.typescript", { link = "@keyword.typescript" })
        -- vim.api.nvim_set_hl(0, "@keyword.import.typescript", { link = "@keyword.typescript" })
        -- vim.api.nvim_set_hl(0, "@punctuation.special.typescript", { link = "@keyword.typescript" })
        -- vim.api.nvim_set_hl(0, "@lsp.typemod.variable.readonly.typescript", { link = "@number" })
    end,

    config = function(_, opts)
        vim.api.nvim_set_hl(0, "@lsp.typemod.variable.readonly.typescript", { link = "@number" })
        dofile(vim.g.base46_cache .. "treesitter")
        require("nvim-treesitter.configs").setup(opts)
    end,
}
