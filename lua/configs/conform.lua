local slow_ft_timeout_ms = {
    php = 2000,
    tex = 2000,
}

local options = {
    notify_one_error = false,

    formatters = {
        latexindent = {
            prepend_args = { "-y", "defaultIndent:'    '" },
        },
    },

    formatters_by_ft = {
        lua = { "stylua" },
        css = { "biome" },
        html = { "biome" },
        json = { "biome" },
        yaml = { "prettierd" },
        typescript = { "biome-organize-imports", "biome" },
        javascript = { "biome-organize-imports", "biome" },
        typescriptreact = { "biome-organize-imports", "biome" },
        javascriptreact = { "biome-organize-imports", "biome" },
        markdown = { "markdownlint-cli2" },
        sh = { "shfmt" },
        toml = { "taplo" },
        nix = { "nixfmt" },
        php = { "php_cs_fixer" },
        python = { "ruff_organize_imports", "ruff_format" },
        tex = { "latexindent" },
    },

    format_on_save = function(bufnr)
        -- These options will be passed to conform.format()
        return {
            timeout_ms = slow_ft_timeout_ms[vim.bo[bufnr].filetype] or 300,
            lsp_fallback = true,
        }
    end,
}

return options
