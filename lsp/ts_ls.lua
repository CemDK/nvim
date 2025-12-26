local function organize_imports()
    local clients = vim.lsp.get_clients { bufnr = 0 }
    for _, client in pairs(clients) do
        if
            client.name == "tsserver"
            or client.name == "typescript-language-server"
            or client.name == "ts_ls"
            or client.name == "tsgo"
        then
            local params = {
                command = "_typescript.organizeImports",
                arguments = { vim.api.nvim_buf_get_name(0) },
                title = "",
            }
            client:request("workspace/executeCommand", params, nil, 0)
            vim.notify("Organized imports", vim.log.levels.INFO)
            vim.cmd "write"
            return
        end
    end
    vim.notify("No TypeScript language server found", vim.log.levels.WARN)
end

local function rename_file()
    local source_file = vim.api.nvim_buf_get_name(0)

    -- Try to use neo-tree's fs_actions which handles everything properly
    local ok, fs_actions = pcall(require, "neo-tree.sources.filesystem.lib.fs_actions")
    if ok and fs_actions.rename_node then
        -- Neo-tree's rename_node will:
        -- 1. Show input prompt
        -- 2. Rename file on disk using uv.fs_rename
        -- 3. Update all buffers properly
        -- 4. Fire FILE_RENAMED event which triggers Snacks.rename.on_rename_file
        -- 5. Snacks handles LSP notifications to update imports in other files
        fs_actions.rename_node(source_file)
    else
        -- Fallback to basic rename if neo-tree is not available
        vim.ui.input({
            prompt = "Rename to: ",
            completion = "file",
            default = source_file,
        }, function(target_file)
            if not target_file or target_file == "" or target_file == source_file then
                return
            end
            vim.lsp.util.rename(source_file, target_file)
        end)
    end
end

-- Alternative implementation using lsp-file-operations directly
-- local function rename_file()
--     local source_file = vim.api.nvim_buf_get_name(0)
--
--     vim.ui.input({
--         prompt = "Rename to: ",
--         completion = "file",
--         default = source_file,
--     }, function(target_file)
--         if not target_file or target_file == "" or target_file == source_file then
--             return
--         end
--
--         -- Use nvim-lsp-file-operations to handle LSP notifications
--         local will_rename_ok, will_rename = pcall(require, "lsp-file-operations.will-rename")
--         local did_rename_ok, did_rename = pcall(require, "lsp-file-operations.did-rename")
--
--         -- Step 1: Send willRenameFiles to LSP (gets workspace edits for import updates)
--         if will_rename_ok then
--             will_rename.callback { old_name = source_file, new_name = target_file }
--         end
--
--         -- Step 2: Rename the actual file and update buffer
--         vim.lsp.util.rename(source_file, target_file)
--
--         -- Step 3: Send didRenameFiles notification to LSP servers
--         if did_rename_ok then
--             vim.schedule(function()
--                 did_rename.callback { old_name = source_file, new_name = target_file }
--             end)
--         end
--
--         vim.notify(
--             string.format(
--                 "✓ Renamed: %s → %s",
--                 vim.fn.fnamemodify(source_file, ":t"),
--                 vim.fn.fnamemodify(target_file, ":t")
--             ),
--             vim.log.levels.INFO
--         )
--     end)
-- end

-- TODO: rename_file and organize_imports is available for all LSP clients right now
-- should restrict to ts_ls only or those that support it
local M = {}
M.on_attach = function(_, bufnr)
    local map = function(mode, keys, func, desc)
        mode = mode or "n"
        vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
    end

    map("n", "<leader>rf", rename_file, "Rename File")
    map("n", "<leader>oi", organize_imports, "[O]rganize [I]mports")
end

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("ts_ls-lsp-attach", { clear = true }),
    callback = function(args)
        M.on_attach(_, args.buf)
    end,
})

return {
    root_markers = { "tsconfig.json", "package.json", "jsconfig.json" },
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

    -- on_attach = M.on_attach,
}
