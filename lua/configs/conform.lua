local options = {
    notify_one_error = false,

    formatters_by_ft = {
        lua = { "stylua" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "biome" },
        yaml = { "prettier" },
        typescript = { "biome" },
        javascript = { "biome" },
        tsx = { "biome" },
        markdown = { "markdownlint-cli2" },
        sh = { "shfmt" },
        toml = { "taplo" },
        nix = { "nixfmt" },
    },

    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
    },
}

return options
