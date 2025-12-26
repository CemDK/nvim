---@diagnostic disable: undefined-doc-name, undefined-field

-- ===========================================================
-- NvChad autocmds
-- ===========================================================
-- user event that loads after UIEnter + only if file buf is there
vim.api.nvim_create_autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("NvFilePost", { clear = true }),
    callback = function(args)
        local file = vim.api.nvim_buf_get_name(args.buf)
        local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })

        if not vim.g.ui_entered and args.event == "UIEnter" then
            vim.g.ui_entered = true
        end

        if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
            vim.api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
            vim.api.nvim_del_augroup_by_name "NvFilePost"

            vim.schedule(function()
                vim.api.nvim_exec_autocmds("FileType", {})

                if vim.g.editorconfig then
                    require("editorconfig").config(args.buf)
                end
            end)
        end
    end,
})

-- ===========================================================
-- Custom autocmds
-- ===========================================================

-- autocmd to highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- autcmd to open neotree
vim.api.nvim_create_autocmd("UiEnter", {
    desc = "Open Neotree automatically",
    group = vim.api.nvim_create_augroup("neotree-nvim-opened", {}),
    callback = function()
        if vim.fn.argc() == 0 then
            vim.cmd "Neotree show"
            -- vim.cmd "Neotree toggle"
        end
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
    callback = function(event)
        local map = function(mode, keys, func, desc)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        --  To jump back, press <C-t>.
        map("n", "gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        map("n", "gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
        map("n", "gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        map("n", "gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
        map("n", "<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
        map("n", "<leader>sds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

        -- Workspaces
        map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd folder")
        map("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
        map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove folder")
        map("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "[W]orkspace [L]ist folders")

        map("n", "<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        map("n", "<leader>sh", vim.lsp.buf.signature_help, "[S]ignature [H]elp")

        -- -----------------------------------------------------------------------------------------------------------
        -- Highlight on hover
        -- -----------------------------------------------------------------------------------------------------------
        -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
        ---@param client vim.lsp.Client
        ---@param method vim.lsp.protocol.Method
        ---@param bufnr? integer some lsp support methods only in specific files
        ---@return boolean
        local function client_supports_method(client, method, bufnr)
            return client:supports_method(method, bufnr)
        end
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if
            client
            and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
        then
            local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
                group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds { group = "kickstart-lsp-highlight", buffer = event2.buf }
                end,
            })
        end

        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map("n", "<leader>tih", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, "[T]oggle Inlay [H]ints")
        end
    end,
})

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "copilot-*",
    callback = function()
        -- Set buffer-local options
        vim.opt_local.relativenumber = false
        vim.opt_local.number = false
        vim.opt_local.conceallevel = 0
    end,
})

-- autocmd to show lsp progress
---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
    ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
        if not client or type(value) ~= "table" then
            return
        end
        local p = progress[client.id]

        for i = 1, #p + 1 do
            if i == #p + 1 or p[i].token == ev.data.params.token then
                p[i] = {
                    token = ev.data.params.token,
                    msg = ("[%3d%%] %s%s"):format(
                        value.kind == "end" and 100 or value.percentage or 100,
                        value.title or "",
                        value.message and (" **%s**"):format(value.message) or ""
                    ),
                    done = value.kind == "end",
                }
                break
            end
        end

        local msg = {} ---@type string[]
        progress[client.id] = vim.tbl_filter(function(v)
            return table.insert(msg, v.msg) or not v.done
        end, p)

        local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
        vim.notify(table.concat(msg, "\n"), vim.log.levels.INFO, {
            id = "lsp_progress",
            title = client.name,
            opts = function(notif)
                notif.icon = #progress[client.id] == 0 and " "
                    or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
        })
    end,
})

-- Set TMUX status bar to nvim background color on VimEnter
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        if vim.env.TMUX and not vim.g.neovide then
            vim.fn.system 'tmux set-option -g status-bg "#23272E"'
        end
    end,
})

-- Set TMUX status bar back to green-ish on VimLeave
vim.api.nvim_create_autocmd("VimLeave", {
    callback = function()
        if vim.env.TMUX then
            vim.fn.system 'tmux set-option -g status-bg "#005F60"'
        end
    end,
})

-- Remove vert fillchar when filetype is neo-tree
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "neo-tree",
--     callback = function()
--         vim.opt_local.fillchars = { eob = " ", vert = " ", horizup = "─" }
--     end,
-- })

-- Wrapped :cnext
-- Cycles through quickfix list items, going to the first item if at the end
vim.api.nvim_create_user_command("CNext", function()
    local qf_list = vim.fn.getqflist()
    if #qf_list == 0 then
        print "No items in quickfix list"
        return
    end
    local current_idx = vim.fn.getqflist({ idx = 0 }).idx
    if current_idx >= #qf_list then
        vim.cmd "cc 1" -- go to first item
    else
        vim.cmd "cnext"
    end
end, {})

-- Wrapped :cprev
-- Cycle through the quickfix list, going to the last item if at the beginning
vim.api.nvim_create_user_command("CPrev", function()
    local qf_list = vim.fn.getqflist()
    if #qf_list == 0 then
        print "No items in quickfix list"
        return
    end
    local current_idx = vim.fn.getqflist({ idx = 0 }).idx
    if current_idx <= 1 then
        vim.cmd("cc " .. #qf_list) -- go to last item
    else
        vim.cmd "cprev"
    end
end, {})

-- ===========================================================
-- LazyVim autocmds
-- ===========================================================
local function augroup(name)
    return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
    group = augroup "close_with_q",
    pattern = {
        "PlenaryTestPopup",
        "checkhealth",
        "dbout",
        "gitsigns-blame",
        "grug-far",
        "help",
        "lspinfo",
        "neotest-output",
        "neotest-output-panel",
        "neotest-summary",
        "notify",
        "qf",
        "spectre_panel",
        "startuptime",
        "tsplayground",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.schedule(function()
            vim.keymap.set("n", "q", function()
                vim.cmd "close"
                pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
            end, {
                buffer = event.buf,
                silent = true,
                desc = "Quit buffer",
            })
        end)
    end,
})

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
    callback = function()
        vim.cmd [[Trouble qflist open]]
    end,
})

vim.api.nvim_create_autocmd("BufRead", {
    callback = function(ev)
        if vim.bo[ev.buf].buftype == "quickfix" then
            vim.schedule(function()
                vim.cmd [[cclose]]
                vim.cmd [[Trouble qflist open]]
            end)
        end
    end,
})
