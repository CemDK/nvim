local markview = require "markview"

markview.setup {
    preview = {
        -- Attach to these filetypes. Avante buffers are intentionally left to
        -- render-markdown.nvim (see plugins/init.lua) to avoid double-rendering.
        filetypes = { "markdown", "quarto", "rmd", "typst", "codecompanion" },
        ignore_buftypes = { "nofile" },

        -- Use mini.icons (already set up via mini.nvim) for code-block labels.
        icon_provider = "mini",

        -- Show the full rendered preview in these modes. Insert mode is left
        -- out, so entering insert automatically drops to the raw view.
        modes = { "n", "no", "c" },

        -- Re-map `gx` to markview's smarter link/heading opener.
        map_gx = true,
    },

    markdown = {
        list_items = {
            -- Hang-indent wrapped list-item lines under the marker instead of
            -- letting them fall back to column 0. Requires the window's `wrap`
            -- option to be on (it is by default).
            wrap = true,
        },
    },
}
