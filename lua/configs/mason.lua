return function(_, opts)
    opts.ensure_installed = opts.ensure_installed or {}
    vim.list_extend(opts.ensure_installed, {
        -- "luacheck",
        "css-lsp",
        "css-variables-language-server",
        "eslint-lsp",
        "eslint_d",
        "html-lsp",
        "json-lsp",
        "lua-language-server",
        "markdown-toc",
        "markdownlint-cli2",
        "marksman",
        "nextls",
        "prettier",
        "shellcheck",
        "shfmt",
        "stylua",
        "tailwindcss-language-server",
        "ts_ls",
        -- "taplo",
        -- "typescript-language-server",
        -- "vtsls",
    })
end
