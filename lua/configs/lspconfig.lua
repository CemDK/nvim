local configs = require "nvchad.configs.lspconfig"
local lspconfig = require "lspconfig"

configs.defaults()

--  Add any additional override configuration in the following tables. Available keys are:
--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
local servers = {
    -- clangd = {},
    -- gopls = {},
    -- pyright = {},
    -- rust_analyzer = {},
    -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
    --
    -- Some languages (like typescript) have entire language plugins that can be useful:
    --    https://github.com/pmizio/typescript-tools.nvim
    --
    -- But for many setups, the LSP (`ts_ls`) will work just fine
    -- ts_ls = {},
    --
    html = {},
    cssls = {},
    -- vtsls = {},

    -- TypeScript
    ts_ls = {
        root_dir = function(...)
            return require("lspconfig.util").root_pattern "tsconfig.json"(...)
        end,
        single_file_support = false,
        settings = {
            typescript = {
                inlayHints = {
                    includeInlayParameterNameHints = "literal",
                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayVariableTypeHints = false,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                },
            },
            javascript = {
                inlayHints = {
                    includeInlayParameterNameHints = "all",
                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayVariableTypeHints = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                },
            },
        },
        capabilites = {
            textDocument = {
                completion = {
                    completionItem = {
                        snippetSupport = true,
                    },
                },
            },
        },
    },

    -- Tailwind
    tailwindcss = {
        root_dir = function(...)
            return require("lspconfig.util").root_pattern "tsconfig.json"(...)
        end,
    },

    -- ESLint
    eslint = {
        root_dir = function(...)
            return require("lspconfig.util").root_pattern "tsconfig.json"(...)
        end,
    },

    -- Nix
    nixd = {
        cmd = { "nixd" },
        settings = {
            nixd = {
                nixpkgs = {
                    expr = "import <nixpkgs> { }",
                },
                formatting = {
                    command = { "nixfmt" },
                },
                options = {
                    nixos = {
                        expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.k-on.options',
                    },
                    home_manager = {
                        expr = '(builtins.getFlake ("git+file://" + toString ./.)).homeConfigurations."ruixi@k-on".options',
                    },
                },
            },
        },
    },

    -- Lua
    lua_ls = {
        -- cmd = { ... },
        -- filetypes = { ... },
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                    path = {
                        "?.lua",
                        "?/init.lua",
                        vim.fn.expand "~/.luarocks/share/lua/5.3/?.lua",
                        vim.fn.expand "~/.luarocks/share/lua/5.3/?/init.lua",
                        "/usr/share/5.3/?.lua",
                        "/usr/share/lua/5.3/?/init.lua",
                    },
                },
                workspace = {
                    checkThirParty = false,
                },
                library = {
                    vim.fn.expand "$VIMRUNTIME/lua",
                    vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
                    vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
                    vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
                    "${3rd}/luv/library",
                    unpack(vim.api.nvim_get_runtime_file("", true)),
                },
                diagnostic = {
                    globals = { "vim" },
                },
                completion = {
                    autoRequire = true,
                    callSnippet = "Replace",
                },
                -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                -- diagnostics = { disable = { 'missing-fields' } },
            },
        },
    },

    -- Terraform
    terraformls = {
        on_attach = function()
            vim.keymap.set("n", "<leader>ff", "<cmd>!terraform fmt %<cr><cr>")
        end,
    },

    -- YAML
    yamlls = {
        settings = {
            yaml = {
                schemaStore = {
                    url = "https://www.schemastore.org/api/json/catalog.json",
                    enable = true,
                },
                style = {
                    flowSequence = "allow",
                },
                keyOrdering = false,
            },
        },
    },

    -- Helm
    helm_ls = {},

    -- Docker
    dockerls = {},
}

-- Diagnostic Config
-- See :help vim.diagnostic.Opts
vim.diagnostic.config {
    severity_sort = true,
    float = { border = "rounded", source = "if_many" },
    underline = { severity = vim.diagnostic.severity.ERROR },
    signs = vim.g.have_nerd_font
            and {
                text = {
                    -- " " " " " " "󰌵"
                    -- "󰅚 " "󰀪 " "󰋽 " "󰌶 "
                    [vim.diagnostic.severity.ERROR] = "󰅚 ",
                    [vim.diagnostic.severity.WARN] = " ",
                    [vim.diagnostic.severity.INFO] = "󰋽 ",
                    [vim.diagnostic.severity.HINT] = "󰌵 ",
                },
            }
        or {},
    virtual_text = {
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

local M = {}

-- export on_attach & capabilities
M.on_attach = function(_, bufnr)
    local map = function(mode, keys, func, desc)
        mode = mode or "n"
        vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
    end
    --  To jump back, press <C-t>.
    map("n", "gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    -- map("n", "gD", require("telescope.builtin").lsp_declaration, "[G]oto [D]eclaration")
    map("n", "gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
    map("n", "gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    map("n", "gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation") -- TODO: fix
    map("n", "gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
    map("n", "<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
    map("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    map("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
    map("n", "<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

    -- map("n", "gd", vim.lsp.buf.definition, "Go to definition")
    -- map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
    -- map("n", "gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    map("n", "<leader>sh", vim.lsp.buf.signature_help, "Show signature help")
    -- map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
    -- map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
    -- map("n", "<leader>D", vim.lsp.buf.type_definition, "Go to type definition")
    map("n", "<leader>ra", require "nvchad.lsp.renamer", "NvRenamer")
    -- map("n", "<leader>wl", function()
    --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, "List workspace folders")
    -- map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
end

-- M.capabilities = vim.lsp.protocol.make_client_capabilities()
--
-- M.capabilities.textDocument.completion.completionItem = {
--     documentationFormat = { "markdown", "plaintext" },
--     snippetSupport = true,
--     preselectSupport = true,
--     insertReplaceSupport = true,
--     labelDetailsSupport = true,
--     deprecatedSupport = true,
--     commitCharactersSupport = true,
--     tagSupport = { valueSet = { 1 } },
--     resolveSupport = {
--         properties = {
--             "documentation",
--             "detail",
--             "additionalTextEdits",
--         },
--     },
-- }

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
-- ----------------------------------------------------------------
-- DO NOT use nvchads on_init, it disables semantic tokens
-- opts.on_init = configs.on_init
-- ----------------------------------------------------------------
for name, opts in pairs(servers) do
    opts.on_attach = M.on_attach
    opts.capabilities = capabilities --vim.tbl_deep_extend("force", {}, capabilities, M.capabilities or {})

    require("mason-lspconfig").setup {
        ensure_installed = {},
        automatic_installation = true,
        handlers = {
            function(server_name)
                lspconfig[name].setup(opts)
            end,
        },
    }
end
