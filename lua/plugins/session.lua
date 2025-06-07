-- Session management and workspace plugins
return {
    -- -------------------------------------------------------------------------------
    -- SESSION & WORKSPACE
    -- -------------------------------------------------------------------------------
    {
        "rmagatti/auto-session",
        lazy = false,
        opts = {
            suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        },
    },
    {
        "wakatime/vim-wakatime",
        lazy = false,
        enabled = vim.fn.hostname() == "Cem-Ryzen",
    },
}
