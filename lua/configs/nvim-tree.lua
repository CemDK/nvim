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

require("nvim-tree").setup {
    filters = {
        enable = true,
        git_ignored = false,
        dotfiles = false,
        git_clean = false,
        no_buffer = false,
        custom = {
            "node_modules", -- filter out node_modules directory
            -- "^\\.git", -- filter out .git directory
            -- "^\\.env",
            -- "^components\\.json$",
            -- "^global\\.d\\.ts$",
            -- "^hidden$",
            -- "^next\\.config\\.ts$",
            -- "^package.json$",
            -- "^pnpm-lock.yaml$",
            -- "^postcss.config.js$",
            -- "^tailwind.config.ts$",
            -- "^tailwind.config.ts_bak$",
            -- "^tsconfig.json$",
        },
        exclude = {},
    },
    -- disable_netrw = true,
    -- hijack_netrw = true,
    --open_on_setup = false,
    open_on_tab = false,
    hijack_cursor = false,
    update_cwd = true,
    hijack_directories = {
        enable = true,
        auto_open = true,
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = {},
    },
    git = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
        ignore = true,
        timeout = 500,
    },
    modified = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
    },
    view = {
        width = 36,
        side = "left",
        --auto_resize = true,
        number = false,
        relativenumber = false,
    },
    actions = {
        --window_picker = { enable = true },
    },
    renderer = {
        highlight_git = true,
        highilight_opened_files = all,
        hidden_display = "all",

        root_folder_modifier = ":t",
        icons = {
            web_devicons = {
                folder = {
                    enable = false,
                    color = true,
                },
            },
            git_placement = "right_align", -- or "after" or "signcolumn"
            modified_placement = "after",
            hidden_placement = "after",
            diagnostics_placement = "right_align",
            padding = " ",

            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
                modified = true,
                diagnostics = true,
            },
            glyphs = {
                -- default = "",
                default = "",
                symlink = "",
                bookmark = "󰆤",
                modified = "●",
                hidden = "󰜌",
                folder = {
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                },
                git = {
                    unstaged = "M",
                    staged = "S",
                    -- unmerged = "UM",
                    unmerged = "",
                    renamed = "R",
                    deleted = "D",
                    untracked = "U",
                    ignored = "I",
                },
            },
        },
    },
}
