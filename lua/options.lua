require "nvchad.options"

-- add yours here!

-- local o = vim.o

-- Set leader key
vim.g.mapleader = " "

-- Encoding
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
-- vim.opt.fileencoding = "utf-8"

-- Save undo history
vim.opt.undofile = true

-- General editor options
vim.opt.title = true -- Set window title to filename
vim.opt.inccommand = "split" -- Show preview of substitutions in a split
vim.opt.scrolloff = 8 -- Lines of context above/below cursor when scrolling
vim.opt.backup = false -- Don't create backup files
vim.opt.showcmd = true -- Show partial command in the last line
-- vim.opt.wrap = false -- Don't wrap lines
vim.opt.backspace = { "start", "eol", "indent" } -- Make backspace work as expected
vim.opt.path:append { "**" } -- Search down into subfolders
vim.opt.wildignore:append { "*node_modules/*" } -- Ignore node_modules in file operations
vim.opt.wildignore:append { "*/node_modules/*" } -- Ignore node_modules in file operations
vim.opt.splitbelow = true -- Open new horizontal splits below
vim.opt.splitright = true -- Open new vertical splits to the right
vim.opt.splitkeep = "cursor" -- Keep cursor in the same position when splitting
vim.opt.formatoptions:append { "r" } -- Continue comments when pressing Enter

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation and tabs
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.tabstop = 4 -- Number of spaces a tab counts for
vim.opt.shiftwidth = 4 -- Number of spaces for each step of indent
vim.opt.softtabstop = 4 -- Number of spaces a tab counts for when editing
vim.opt.wrap = false -- Don't wrap lines
vim.opt.autoindent = true -- Copy indent from current line when starting a new line
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.smarttab = true -- Tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
vim.opt.breakindent = true -- Wrapped lines preserve indentation

-- Search options
vim.opt.incsearch = true -- Show matches while typing search pattern
vim.opt.ignorecase = true -- Ignore case in search patterns
vim.opt.smartcase = true -- Override ignorecase when pattern has upper case
vim.opt.hlsearch = true -- Highlight all matches of previous search

-- Editor UI
vim.opt.cursorline = true -- Highlight the current line
vim.opt.cursorlineopt = "both" -- Only highlight the line number of current line
vim.opt.termguicolors = true -- Enable true color support

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
