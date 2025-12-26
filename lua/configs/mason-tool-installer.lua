-- not being used currently, but kept for reference
-- just use nix to manage lsp servers and formatters
return {
    ensure_installed = {
        -- web
        "css-lsp",
        "css-variables-language-server",
        "eslint",
        "eslint-lsp",
        "eslint_d",
        "html",
        "html-lsp",
        "json-lsp",
        "prettier",
        "tailwindcss",
        "tailwindcss-language-server",
        -- "ts_ls",
        -- "typescript-language-server",
        -- "vtsls",

        -- lua
        -- "luacheck",
        "lua_ls",
        "lua-language-server",
        "stylua",

        "markdown-toc",
        "markdownlint-cli2",
        "marksman",
        "shellcheck",
        "shfmt",

        -- "alejandra", -- nix, using nixfmt instead
        -- "nil_ls", -- nix, but don't like it
        -- "nixd",
        "taplo",
        "yamlfmt",
        "yamlls",
        "helm_ls",
        "dockerls",
        "terraformls",
        -- "hclfmt",

        -- "gopls",
        -- "goimports",
        -- "gofumpt",

        -- rust
        "rust-analyzer",

        -- Debug
        -- "codelldb",
    },

    run_on_start = true,

    integrations = {
        ["mason-lspconfig"] = true,
        -- ["mason-null-ls"] = true,
        -- ["mason-nvim-dap"] = true,
    },
}
