dofile(vim.g.base46_cache .. "lsp")

local servers = {
    -- -----------------------------------------------------------------------------------
    -- Web Development
    -- -----------------------------------------------------------------------------------
    cssls = {},
    -- css_variables = {}, -- can do goto definition on css variables in css files
    -- cssmodules_ls = {}, -- can do goto definition on css modules in js/ts files
    html = {},
    -- tsgo currently doesn't support organize imports and rename file
    -- tsgo = {},
    ts_ls = {},
    tailwindcss = {},
    eslint = {},
    -- -----------------------------------------------------------------------------------

    nixd = {},
    lua_ls = {},
    terraformls = {},
    yamlls = {},
    bashls = {},
    rust_analyzer = {},

    -- helm_ls = {},
    -- dockerls = {},
}

-- Diagnostic Config
-- See :help vim.diagnostic.Opts
vim.diagnostic.config {
    severity_sort = true,
    float = { border = "single", source = "if_many" },
    underline = true, -- { severity = vim.diagnostic.severity.ERROR },
    signs = vim.g.have_nerd_font
            and {
                text = {
                    -- " " " " " " "󰌵"
                    -- "󰅚 " "󰀪 " "󰋽 " "󰌶 "
                    [vim.diagnostic.severity.ERROR] = " ",
                    [vim.diagnostic.severity.WARN] = " ",
                    [vim.diagnostic.severity.INFO] = "󰋽 ",
                    [vim.diagnostic.severity.HINT] = "󰌵 ",
                },
            }
        or {},
    virtual_text = {
        prefix = "",
        source = "if_many",
        spacing = 2,
        format = function(diagnostic)
            local diagnostic_message = {
                [vim.diagnostic.severity.ERROR] = diagnostic.message,
                [vim.diagnostic.severity.WARN] = diagnostic.message,
                [vim.diagnostic.severity.INFO] = diagnostic.message,
                [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
        end,
    },
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
capabilities = vim.tbl_deep_extend("force", capabilities, require("lsp-file-operations").default_capabilities())
vim.lsp.config("*", { capabilities = capabilities })

for name, opts in pairs(servers) do
    vim.lsp.config(name, opts)
    vim.lsp.enable(name)
end
