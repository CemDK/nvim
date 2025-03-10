local options = {
    formatters_by_ft = {
        lua = { "stylua" },
        css = { "prettier" },
        html = { "prettier" },
        typescript = { "eslint" },
        javascript = { "eslint" },
        json = { "prettier" },
        markdown = { "markdownlint-cli2" },
        sh = { "shfmt" },
        yaml = { "prettier" },
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
