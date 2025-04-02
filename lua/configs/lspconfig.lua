local configs = require "configs.nvchad-lspconfig"
configs.defaults()

local function organize_imports()
    local clients = vim.lsp.get_active_clients { bufnr = 0 }
    for _, client in pairs(clients) do
        -- Only send to TypeScript related language servers
        if client.name == "tsserver" or client.name == "typescript-language-server" or client.name == "ts_ls" then
            local params = {
                command = "_typescript.organizeImports",
                arguments = { vim.api.nvim_buf_get_name(0) },
                title = "",
            }
            client.request("workspace/executeCommand", params, nil, 0)
            return
        end
    end
    -- If we get here, no TypeScript server was found
    vim.notify("No TypeScript language server found", vim.log.levels.WARN)
end

local function rename_file()
    local source_file, target_file

    vim.ui.input({
        prompt = "Source : ",
        completion = "file",
        default = vim.api.nvim_buf_get_name(0),
    }, function(input)
        source_file = input
    end)

    vim.ui.input({
        prompt = "Target : ",
        completion = "file",
        -- default = source_file,
        default = vim.api.nvim_buf_get_name(0),
    }, function(input)
        target_file = input
    end)

    local params = {
        command = "_typescript.applyRenameFile",
        arguments = {
            {
                sourceUri = source_file,
                targetUri = target_file,
            },
        },
        title = "",
    }

    if not source_file or not target_file then
        return
    end
    vim.lsp.util.rename(source_file, target_file)
    vim.lsp.buf.execute_command(params)
end

local servers = {
    html = {},
    cssls = {},

    -- TypeScript
    -- vtsls = {},
    -- Some languages (like typescript) have entire language plugins that can be useful:
    --    https://github.com/pmizio/typescript-tools.nvim
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
                preferences = {
                    allowIncompleteCompletions = true,
                    autoImportFileExcludePatterns = {},

                    -- module import settings
                    importModuleSpecifierPreference = "non-relative",
                    importModuleSpecifierEnding = "js",
                    organizeImportsIgnoreCase = true,
                    disableOrganizeImports = true,

                    includeAutomaticOptionalChainCompletions = true,
                    includeCompletionsForImportStatements = true,
                    includeCompletionsWithClassMemberSnippets = true,
                    includeCompletionsWithInsertText = true,
                    includeCompletionsWithObjectLiteralMethodSnippets = true,
                    includeCompletionsWithSnippetText = true,
                    includePackageJsonAutoImports = "auto",
                    quotePreference = "auto",
                    useLabelDetailsInCompletionEntries = true,
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
                preferences = {
                    includeCompletionsForImportStatements = true,
                    quotePreference = "auto",
                    importModuleSpecifierPreference = "non-relative",
                },
            },
        },
        capabilities = {
            textDocument = {
                completion = {
                    completionItem = {
                        snippetSupport = true,
                    },
                },
            },
        },
        commands = {
            OrganizeImports = {
                organize_imports,
                description = "Organize Imports",
            },
            RenameFile = {
                rename_file,
                description = "Rename File",
            },
        },
    },

    -- Tailwind
    tailwindcss = {
        root_dir = function(...)
            return require("lspconfig.util").root_pattern "tsconfig.json"(...)
        end,
        settings = {
            typescript = {
                preferences = {
                    disableOrganizeImports = true,
                },
            },
        },
    },

    -- ESLint
    eslint = {
        root_dir = function(...)
            return require("lspconfig.util").root_pattern "tsconfig.json"(...)
        end,
    },

    -- Nix
    nixd = {
        root_dir = function(...)
            return require("lspconfig.util").root_pattern "flake.nix"(...)
        end,
        cmd = { "nixd" },
        settings = {
            -- filetypes = { "nix" },
            nixd = {
                nixpkgs = {
                    expr = "import <nixpkgs> { }",
                },
                formatting = {
                    command = { "nixfmt" },
                },
                options = {
                    nixos = {
                        -- expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.k-on.options',
                        expr = "import <nixpkgs/nixos/modules>",
                    },
                    home_manager = {
                        -- expr = '(builtins.getFlake ("git+file://" + toString ./.)).homeConfigurations."cem@Cem-Ryzen".options',
                        -- expr = "import <home-manager/modules>",
                        expr = '(builtins.getFlake "/home/cem/.config/nix").homeConfigurations."cem@Cem-Ryzen".options',
                    },
                    -- nix_darwin = {
                    --     expr = '(builtins.getFlake ("git+file://" + toString ./.)).darwinConfigurations."ruixi@k-on".options',
                    -- },
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
                    maxPreload = 100000,
                    preloadFileSize = 10000,
                    checkThirParty = false,
                    library = {
                        [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                        [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                        [vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types"] = true,
                        [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
                        ["${3rd}/luv/library"] = true,
                        [vim.fn.stdpath "data" .. "/site/pack/packer/start/nvim-lspconfig/lua"] = true,
                    },
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
                    -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                    -- disable = { "missing-fields" },
                },
                completion = {
                    autoRequire = true,
                    callSnippet = "Replace",
                },
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
    bashls = {},
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
    -- map("n", "gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    map("n", "gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
    -- map("n", "gD", require("telescope.builtin").lsp_declaration, "[G]oto [D]eclaration")
    map("n", "gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    map("n", "gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
    map("n", "<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
    map("n", "<leader>sds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    map("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
    map("n", "<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    map("n", "<leader>sh", vim.lsp.buf.signature_help, "Show signature help")
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
    map("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "List workspace folders")
    --

    map("n", "<leader>rf", rename_file, "Rename File")
    map("n", "<leader>oi", organize_imports, "[O]rganize [I]mports") -- Add this line

    map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
end

M.organize_imports = organize_imports

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
capabilities = vim.tbl_deep_extend("force", capabilities, require("lsp-file-operations").default_capabilities())
-- capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities(capabilities))
-- print(vim.inspect(require("lsp-file-operations").default_capabilities()))
-- print(vim.inspect(capabilities))

-- ----------------------------------------------------------------
-- TODO: don't do this in a loop,
-- we are requiring the same config multiple times I think
-- check what is passed to handlers and make sure nixd is configured here
--
-- ----------------------------------------------------------------
for name, opts in pairs(servers) do
    -- print("Setting up LSP for " .. name)
    -- opts.on_init = configs.on_init -- don't use nvchads on_init, it disables semantic tokens
    opts.on_attach = M.on_attach
    opts.capabilities = capabilities

    require("mason-lspconfig").setup {
        ensure_installed = {},
        automatic_installation = true,
        handlers = {
            function(input)
                require("lspconfig")[name].setup(opts)
            end,
        },
    }
end
