dofile(vim.g.base46_cache .. "telescope")

local actions = require "telescope.actions"
local open_with_trouble = require("trouble.sources.telescope").open

-- Use this to add more results without clearing the trouble list
local add_to_trouble = require("trouble.sources.telescope").add

local telescope = require "telescope"
telescope.setup {
    defaults = {
        winblend = 80,
        prompt_prefix = "   ",
        selection_caret = " ",
        entry_prefix = " ",
        sorting_strategy = "ascending",
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
            },
            width = 0.87,
            height = 0.80,
        },
        mappings = {
            n = {
                ["q"] = require("telescope.actions").close,
                ["<c-q>"] = open_with_trouble,
                ["<c-a>"] = add_to_trouble,
            },
            i = {
                ["<ESC>"] = require("telescope.actions").close,
                ["<c-q>"] = open_with_trouble,
                ["<c-a>"] = add_to_trouble,
            },
        },
    },

    extensions_list = { "themes", "terms" },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- "ignore_case" or "respect_case" or "smart_case"
        },
    },
}

telescope.load_extension "fzf"
telescope.load_extension "lazygit"
telescope.load_extension "refactoring"

vim.keymap.set({ "n", "x" }, "<leader>rr", function()
    require("telescope").extensions.refactoring.refactors()
end)
