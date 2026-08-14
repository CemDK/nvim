return {
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
            telemetry = { enable = false },
            workspace = {
                maxPreload = 100000,
                preloadFileSize = 10000,
                checkThirdParty = false,
                library = {
                    [vim.env.VIMRUNTIME] = true,
                    [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                    [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                    [vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types"] = true,
                    [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
                    ["${3rd}/luv/library"] = true,
                    ["${3rd}/luassert/library"] = true,
                    [vim.fn.stdpath "data" .. "/site/pack/packer/start/nvim-lspconfig/lua"] = true,
                },
            },
            diagnostics = {
                globals = { "vim", "MiniIcons" },
                -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                -- disable = { "missing-fields" },
            },
            completion = {
                autoRequire = true,
                callSnippet = "Replace",
            },
        },
    },
}
