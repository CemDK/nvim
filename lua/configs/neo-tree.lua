require("nvim-web-devicons").setup {
    -- DevIcon will be appended to `name`
    override = {
        fish = {
            icon = "",
            color = "#428850",
            cterm_color = "65",
            name = "fish",
        },
    },
    color_icons = true,
    default = true,
    strict = true,
    -- takes effect when `strict` is true
    override_by_filename = {
        [".gitignore"] = {
            icon = "",
            color = "#f1502f",
            name = "Gitignore",
        },
    },
    -- takes effect when `strict` is true
    override_by_extension = {
        ["log"] = {
            icon = "",
            color = "#81e043",
            name = "Log",
        },
    },
}

vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

require("neo-tree").setup {
    hide_root_node = true,
    retain_hidden_root_indent = true,
    close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
    open_files_using_relative_paths = false,
    sort_case_insensitive = false, -- used when sorting files and directories in the tree
    sort_function = nil, -- use a custom function for sorting files and directories in the tree
    -- sort_function = function (a,b)
    --       if a.type == b.type then
    --           return a.path > b.path
    --       else
    --           return a.type > b.type
    --       end
    --   end , -- this sorts files and directories descendantly

    default_component_configs = {
        container = {
            enable_character_fade = true,
        },
        indent = {
            indent_size = 2,
            padding = 1, -- extra padding on left hand side

            -- indent guides
            with_markers = false,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",

            -- expander config, needed for nesting files
            with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
        },
        icon = {
            folder_closed = "󰉋",
            folder_open = "󰝰",
            folder_empty = "",
            provider = function(icon, node, _)
                local success, web_devicons = pcall(require, "nvim-web-devicons")
                if success then
                    if node.type == "file" or node.type == "terminal" then
                        local name = node.type == "terminal" and "terminal" or node.name
                        local devicon, hl = web_devicons.get_icon(name)
                        icon.text = devicon or icon.text
                        icon.highlight = hl or icon.highlight
                    elseif node.type == "directory" then
                        -- local mini_icons = require "mini.icons"
                        local text, hl

                        if node.name == ".npm" then
                            text = MiniIcons.get("directory", "node_modules")
                        elseif node.name == "actions" then
                            text = MiniIcons.get("directory", "proc")
                            hl = "Identifier"
                        elseif node.name == "app" then
                            text = MiniIcons.get("directory", "Applications")
                            hl = "Identifier"
                        elseif node.name == "components" then
                            text = MiniIcons.get("directory", "Music")
                            hl = "Boolean"
                        elseif node.name == "contexts" then
                            text = MiniIcons.get("directory", "etc")
                            hl = "Type"
                        elseif node.name == "hooks" then
                            text = MiniIcons.get("directory", "Downloads")
                            hl = "String"
                        elseif node.name == "lib" then
                            text = MiniIcons.get("directory", "lib")
                            hl = "Special"
                        elseif node.name == "models" or node.name == "schemas" then
                            text = MiniIcons.get("directory", "ProgramData")
                            hl = "Function"
                        elseif node.name == "public" then
                            text = MiniIcons.get("directory", "Public")
                            hl = "Function"
                        elseif
                            node.name == "styles"
                            or node.name == "layout"
                            or node.name == "themes"
                            or node.name == "storage"
                        then
                            text = MiniIcons.get("directory", "Templates")
                            hl = "Keyword"
                        elseif node.name == "types" then
                            text = MiniIcons.get("directory", "System")
                            hl = "Type"
                        elseif node.name == "plugins" or node.name == "features" then
                            text = MiniIcons.get("directory", "opt")
                            hl = "String"
                        elseif node.name == "configs" then
                            text = MiniIcons.get("directory", ".config")
                            hl = "Type"
                        elseif node.name == "(ROOT)" then
                            text = MiniIcons.get("directory", "Desktop")
                            hl = "Boolean"
                        elseif node.name == "api" then
                            text = MiniIcons.get("directory", "Network")
                            hl = "Identifier"
                        elseif node.name == "fonts" then
                            text = MiniIcons.get("directory", "Documents")
                            hl = "String"
                        elseif node.name == "utils" then
                            text = MiniIcons.get("directory", "etc")
                            hl = "Special"
                        elseif node.name == "ui" then
                            text = MiniIcons.get("directory", "Pictures")
                            hl = "Identifier"
                        elseif node.name == "lua" then
                            text = MiniIcons.get("directory", "Favorites")
                            hl = "Identifier"
                        else
                            text, hl = MiniIcons.get("directory", node.name)
                            if node:is_expanded() then
                                text = nil
                            end
                        end

                        icon.text = text or icon.text
                        if hl ~= "MiniIconsAzure" and hl ~= "MiniIconsBlue" then
                            icon.highlight = hl or icon.highlight
                        end
                    end
                end
            end,
            -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
            -- then these will never be used.
            default = "*",
            highlight = "NeoTreeFileIcon",
        },
        modified = {
            -- symbol = "[+]",
            symbol = "●",
            highlight = "NeoTreeModified",
        },
        name = {
            trailing_slash = false,
            use_git_status_colors = false,
            highlight = "NeoTreeFileName",
        },
        git_status = {
            symbols = {
                -- Change type
                added = "A", -- or "✚", but this is redundant info if you use git_status_colors on the name
                modified = "M", -- but this is redundant info if you use git_status_colors on the name
                deleted = "D", -- this can only be used in the git_status source
                renamed = "R", -- this can only be used in the git_status source
                -- Status type
                untracked = "U",
                ignored = "",
                unstaged = "", -- "󰄱",
                staged = "",
                conflict = "",
            },
        },
        -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
        file_size = {
            enabled = true,
            width = 12, -- width of the column
            required_width = 64, -- min width of window required to show this column
        },
        type = {
            enabled = true,
            width = 10, -- width of the column
            required_width = 122, -- min width of window required to show this column
        },
        last_modified = {
            enabled = true,
            width = 20, -- width of the column
            required_width = 88, -- min width of window required to show this column
        },
        created = {
            enabled = true,
            width = 20, -- width of the column
            required_width = 110, -- min width of window required to show this column
        },
        symlink_target = {
            enabled = false,
        },
    },
    -- A list of functions, each representing a global custom command
    -- that will be available in all sources (if not overridden in `opts[source_name].commands`)
    -- see `:h neo-tree-custom-commands-global`
    commands = {},
    window = {
        position = "left",
        width = 40,
        mapping_options = {
            noremap = true,
            nowait = true,
        },
        mappings = {
            ["<space>"] = {
                "toggle_node",
                nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
            },
            ["<2-LeftMouse>"] = "open",
            ["<cr>"] = "open",
            ["<esc>"] = "cancel", -- close preview or floating neo-tree window
            ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = false } },
            -- Read `# Preview Mode` for more information
            ["l"] = "focus_preview",
            ["S"] = "open_split",
            ["s"] = "open_vsplit",
            -- ["S"] = "split_with_window_picker",
            -- ["s"] = "vsplit_with_window_picker",
            ["t"] = "open_tabnew",
            -- ["<cr>"] = "open_drop",
            -- ["t"] = "open_tab_drop",
            ["w"] = "open_with_window_picker",
            --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
            ["C"] = "close_node",
            -- ['C'] = 'close_all_subnodes',
            ["z"] = "close_all_nodes",
            --["Z"] = "expand_all_nodes",
            ["a"] = {
                "add",
                -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
                -- some commands may take optional config options, see `:h neo-tree-mappings` for details
                config = {
                    show_path = "none", -- "none", "relative", "absolute"
                },
            },
            ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
            ["d"] = "delete",
            ["r"] = "rename",
            ["b"] = "rename_basename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
            -- ["c"] = {
            --  "copy",
            --  config = {
            --    show_path = "none" -- "none", "relative", "absolute"
            --  }
            --}
            ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
            ["i"] = "show_file_details",
            -- ["i"] = {
            --   "show_file_details",
            --   -- format strings of the timestamps shown for date created and last modified (see `:h os.date()`)
            --   -- both options accept a string or a function that takes in the date in seconds and returns a string to display
            --   -- config = {
            --   --   created_format = "%Y-%m-%d %I:%M %p",
            --   --   modified_format = "relative", -- equivalent to the line below
            --   --   modified_format = function(seconds) return require('neo-tree.utils').relative_date(seconds) end
            --   -- }
            -- },
        },
    },

    nesting_rules = require "configs.neo-tree-nesting-rules",

    filesystem = {
        filtered_items = {
            visible = false, -- when true, they will just be displayed differently than normal items
            show_hidden_count = false,
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_hidden = true, -- only works on Windows for hidden files/directories
            hide_by_name = {
                "node_modules",
                ".git",
                ".next",
                ".vscode",
            },
            hide_by_pattern = { -- uses glob style patterns
                --"*.meta",
                --"*/src/*/tsconfig.json",
            },
            always_show = { -- remains visible even if other settings would normally hide it
                --".gitignored",
            },
            always_show_by_pattern = { -- uses glob style patterns
                --".env*",
            },
            never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                ".DS_Store",
                "thumbs.db",
            },
            never_show_by_pattern = { -- uses glob style patterns
                --".null-ls_*",
            },
        },
        follow_current_file = {
            enabled = true, -- This will find and focus the file in the active buffer every time
            --               -- the current file is changed while the tree is open.
            leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
        group_empty_dirs = false, -- when true, empty folders will be grouped together
        hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
        -- in whatever position is specified in window.position
        -- "open_current",  -- netrw disabled, opening a directory opens within the
        -- window like netrw would, regardless of window.position
        -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
        use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
        -- instead of relying on nvim autocmd events.
        window = {
            mappings = {
                ["<bs>"] = "navigate_up",
                ["."] = "set_root",
                ["H"] = "toggle_hidden",
                ["/"] = "fuzzy_finder",
                ["D"] = "fuzzy_finder_directory",
                ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
                -- ["D"] = "fuzzy_sorter_directory",
                ["f"] = "filter_on_submit",
                ["<c-x>"] = "clear_filter",
                ["[g"] = "prev_git_modified",
                ["]g"] = "next_git_modified",
                ["o"] = {
                    "show_help",
                    nowait = false,
                    config = { title = "Order by", prefix_key = "o" },
                },
                ["oa"] = "avante_add_files",
                ["oc"] = { "order_by_created", nowait = false },
                ["od"] = { "order_by_diagnostics", nowait = false },
                ["og"] = { "order_by_git_status", nowait = false },
                ["om"] = { "order_by_modified", nowait = false },
                ["on"] = { "order_by_name", nowait = false },
                ["os"] = { "order_by_size", nowait = false },
                ["ot"] = { "order_by_type", nowait = false },
                -- ['<key>'] = function(state) ... end,
            },
            fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
                ["<down>"] = "move_cursor_down",
                ["<C-n>"] = "move_cursor_down",
                ["<up>"] = "move_cursor_up",
                ["<C-p>"] = "move_cursor_up",
                ["<esc>"] = "close",
                -- ['<key>'] = function(state, scroll_padding) ... end,
            },
        },

        commands = {
            avante_add_files = function(state)
                local node = state.tree:get_node()
                local filepath = node:get_id()
                local relative_path = require("avante.utils").relative_path(filepath)

                local sidebar = require("avante").get()

                local open = sidebar:is_open()
                -- ensure avante sidebar is open
                if not open then
                    require("avante.api").ask()
                    sidebar = require("avante").get()
                end

                sidebar.file_selector:add_selected_file(relative_path)

                -- remove neo tree buffer
                if not open then
                    sidebar.file_selector:remove_selected_file "neo-tree filesystem [1]"
                end
            end,
        },
    },

    buffers = {
        follow_current_file = {
            enabled = true, -- This will find and focus the file in the active buffer every time
            --              -- the current file is changed while the tree is open.
            leave_dirs_open = true, -- `false` closes auto expanded dirs, such a with `:Neotree reveal`
        },
        group_empty_dirs = true, -- when true, empty folders will be grouped together
        show_unloaded = true,
        window = {
            mappings = {
                ["d"] = "buffer_delete",
                ["bd"] = "buffer_delete",
                ["<bs>"] = "navigate_up",
                ["."] = "set_root",
                ["o"] = {
                    "show_help",
                    nowait = false,
                    config = { title = "Order by", prefix_key = "o" },
                },
                ["oc"] = { "order_by_created", nowait = false },
                ["od"] = { "order_by_diagnostics", nowait = false },
                ["om"] = { "order_by_modified", nowait = false },
                ["on"] = { "order_by_name", nowait = false },
                ["os"] = { "order_by_size", nowait = false },
                ["ot"] = { "order_by_type", nowait = false },
            },
        },
    },
    git_status = {
        window = {
            position = "float",
            mappings = {
                ["A"] = "git_add_all",
                ["gu"] = "git_unstage_file",
                ["ga"] = "git_add_file",
                ["gr"] = "git_revert_file",
                ["gc"] = "git_commit",
                ["gp"] = "git_push",
                ["gg"] = "git_commit_and_push",
                ["o"] = {
                    "show_help",
                    nowait = false,
                    config = { title = "Order by", prefix_key = "o" },
                },
                ["oc"] = { "order_by_created", nowait = false },
                ["od"] = { "order_by_diagnostics", nowait = false },
                ["om"] = { "order_by_modified", nowait = false },
                ["on"] = { "order_by_name", nowait = false },
                ["os"] = { "order_by_size", nowait = false },
                ["ot"] = { "order_by_type", nowait = false },
            },
        },
    },
}

-- vim.keymap.set("n", "<leader>e", "<Cmd>Neotree reveal<CR>")
