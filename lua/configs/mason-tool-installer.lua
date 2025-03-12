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
        "ts_ls",

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

        "alejandra", -- nix
        "nil_ls", --nix
        "taplo",
        "yamlfmt",
        "yamlls",
        "helm_ls",
        "dockerls",
        "terraformls",
        -- "hclfmt",
        -- "typescript-language-server",
        -- "vtsls",
    },

    run_on_start = true,

    integrations = {
        ["mason-lspconfig"] = true,
        -- ["mason-null-ls"] = true,
        -- ["mason-nvim-dap"] = true,
    },
}
