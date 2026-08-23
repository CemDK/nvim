local options = {
    notify_one_error = false,

    formatters_by_ft = {
        lua = { "stylua" },
        css = { "biome" },
        html = { "biome" },
        json = { "biome" },
        yaml = { "biome" },
        typescript = { "biome" },
        javascript = { "biome" },
        typescriptreact = { "biome" },
        javascriptreact = { "biome" },
        markdown = { "markdownlint-cli2" },
        sh = { "shfmt" },
        toml = { "taplo" },
        nix = { "nixfmt" },
        php = { "php_cs_fixer" },
    },

    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 300,
        lsp_fallback = true,
    },
}

return options
