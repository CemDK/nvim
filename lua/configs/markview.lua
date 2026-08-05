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
            -- Hang-indent soft-wrapped list-item lines under the marker instead
            -- of letting them fall back to column 0. Requires the window's
            -- `wrap` option to be on (it is by default).
            -- wrap = true,

            -- Disable markview's `add_padding`: by default it conceals a list
            -- item's real leading whitespace and substitutes its own computed
            -- virtual indent. That clashes with hard-wrapped continuation lines
            -- that are manually aligned under the marker text, stacking extra
            -- indent in front of the existing alignment. Turning it off makes
            -- markview respect the source indentation verbatim and only swap the
            -- marker glyph.
            marker_minus = { add_padding = false },
            marker_plus = { add_padding = false },
            marker_star = { add_padding = false },
            marker_dot = { add_padding = false },
            marker_parenthesis = { add_padding = false },
        },
    },

    markdown_inline = {
        checkboxes = {
            -- markview conceals the whole `- [ ] ` marker and renders just the
            -- checkbox glyph, which is two cells wide in our font. That collapses
            -- 6 source columns down to ~3, so hard-wrapped continuation lines
            -- (aligned to 6 literal spaces) no longer line up. Prepend two spaces
            -- to each glyph so the marker renders as "  <icon>" and keeps the
            -- original column width. Only `text` is overridden; hl/scope_hl are
            -- preserved by markview's deep merge.
            checked = { text = "    󰗠" },
            unchecked = { text = "    󰄰" },
        },
    },
}
