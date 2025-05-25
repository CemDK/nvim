--------------------------------------------------
-- Core Settings
--------------------------------------------------

-- Set leader key
vim.g.mapleader = " "

-- Encoding
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
-- vim.opt.fileencoding = "utf-8"

-- Performance
vim.opt.timeoutlen = 400 -- Time to wait for a mapped sequence to complete (in ms)
vim.opt.updatetime = 250 -- Faster completion + swap file write interval (used by gitsigns)

--------------------------------------------------
-- User Interface
--------------------------------------------------

-- Line display
vim.opt.number = true -- Show line numbers
vim.opt.numberwidth = 4 -- Minimum columns for line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.ruler = false -- Don't show cursor position in command line (redundant with statusline)
vim.opt.showmode = false -- Don't show mode in command line (shown in statusline)
vim.opt.showcmd = true -- Show partial command in the last line

-- Visual elements
vim.opt.title = true -- Set window title to filename
vim.opt.cursorline = true -- Highlight the current line
vim.opt.cursorlineopt = "both" -- Highlight both the line and line number
vim.opt.termguicolors = true -- Enable true color support
vim.opt.signcolumn = "yes" -- Always show the sign column
vim.opt.laststatus = 3 -- Global statusline
-- Change fillchars
vim.opt.fillchars = {
    stl = " ", -- Statusline of the current window
    stlnc = " ", -- Statusline of non-current windows
    wbr = " ", -- Window bar
    horiz = " ", -- Horizontal separators for :split
    horizup = " ", -- Upwards facing horizontal separator
    horizdown = " ", -- Downwards facing horizontal separator
    vert = " ", -- Vertical separators for :vsplit
    vertleft = " ", -- Left facing vertical separator
    vertright = " ", -- Right facing vertical separator
    verthoriz = " ", -- Overlapping vertical and horizontal separator

    fold = "·", -- Filling 'foldtext'
    foldopen = "-", -- Mark the beginning of a fold
    foldclose = "+", -- Show a closed fold
    foldsep = "│", -- Open fold middle marker
    diff = "-", -- Deleted lines of the 'diff' option
    msgsep = " ", -- Message separator for 'display'
    eob = " ", -- Empty lines at the end of a buffer
    lastline = "@", -- 'display' contains lastline/truncate
}

-- Whitespace visualization
vim.opt.list = true -- Show invisible characters
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Scrolling and viewport
vim.opt.scrolloff = 8 -- Keep 8 lines above/below cursor when scrolling
vim.opt.splitbelow = true -- Open new horizontal splits below current buffer
vim.opt.splitright = true -- Open new vertical splits to the right
vim.opt.splitkeep = "cursor" -- Keep cursor position when splitting

--------------------------------------------------
-- Editing Behavior
--------------------------------------------------

-- Text wrapping
vim.opt.wrap = true -- Wrap lines
vim.opt.breakindent = true -- Wrapped lines preserve indentation
vim.opt.linebreak = true -- Break long lines at word boundaries
vim.opt.textwidth = 112 -- Maximum width of text before wrapping
-- vim.opt.colorcolumn = "+1" -- Highlight column after textwidth
-- vim.opt.columns = 113 -- Sets width of the window to 113 columns, not what I want

-- Indentation and tabs
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.tabstop = 4 -- Number of spaces a tab counts for
vim.opt.shiftwidth = 4 -- Number of spaces for each step of indent
vim.opt.softtabstop = 4 -- Number of spaces a tab counts for when editing
vim.opt.autoindent = true -- Copy indent from current line when starting a new line
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.smarttab = true -- Tab respects 'tabstop', 'shiftwidth', and 'softtabstop'

-- File handling
vim.opt.backup = false -- Don't create backup files
vim.opt.undofile = true -- Save undo history to file
vim.opt.path:append { "**" } -- Search down into subfolders
vim.opt.wildignore:append { "*node_modules/*", "*/node_modules/*" } -- Ignore node_modules in file operations

-- Editing experience
vim.opt.backspace = { "start", "eol", "indent" } -- Make backspace work as expected
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.mouse = "a" -- Enable mouse in all modes
vim.opt.inccommand = "split" -- Show preview of substitutions in a split
vim.opt.formatoptions:append { "r" } -- Continue comments when pressing Enter

-- Navigation behavior
vim.opt.whichwrap:append "<>[]hl" -- Move to prev/next line at line ends

--------------------------------------------------
-- Search and Find
--------------------------------------------------

vim.opt.incsearch = true -- Show matches while typing search pattern
vim.opt.ignorecase = true -- Ignore case in search patterns
vim.opt.smartcase = true -- Override ignorecase when pattern has upper case
vim.opt.hlsearch = true -- Highlight all matches of previous search

--------------------------------------------------
-- System and Integration
--------------------------------------------------

-- Disable nvim intro message
vim.opt.shortmess:append "sI"

-- Disable some default providers (improves startup time)
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Add binaries installed by mason.nvim to path
local is_windows = vim.fn.has "win32" ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, sep) .. delim .. vim.env.PATH
