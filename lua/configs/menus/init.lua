-- Context menus (nvzone/menu), opened by right click or <leader>m.
--
-- Each context file returns a function(ctx) -> items. The menu is built when it opens, so sections can depend
-- on what is under the cursor (LSP client, diagnostics, git hunk, neo-tree source, visual selection).
--
-- Item hints (`rtxt`) are also bound as hotkeys inside the menu when it is opened from the keyboard. Do not use
-- keys the menu needs itself: <CR>, q, <Esc>, h, j, k, l, <Tab>, <S-Tab>, <C-t>.
local M = {}

local api = vim.api

local group = api.nvim_create_augroup("ContextMenu", { clear = true })

local function menus_open()
    return #require("menu.state").bufids > 0
end

-- Mouse clicks while a menu is open. The plugin's own <LeftMouse> mapping replays every click with
-- `normal! <LeftMouse>`, which moves focus (and the cursor) into the menu, misses clicks on statuslines, does not
-- exist for keyboard-opened menus, and stays installed after an item is clicked. This replaces it:
--   - a click on a menu runs the item under the mouse; focus stays where it was
--   - any other click closes all menus, then the click is replayed where it landed
local MOUSE_DESC = "Menu: click (close when outside)"

local function release_mouse()
    if vim.fn.maparg("<LeftMouse>", "n", false, true).desc == MOUSE_DESC then
        pcall(vim.keymap.del, "n", "<LeftMouse>")
    end
end

-- Run the menu item under the mouse. volt's own handler only sees clicks that reach the menu window as keys,
-- which would move focus there, so its click table is used directly.
local function click_menu_item(buf, pos)
    local v = require("volt.state")[buf]
    local col = pos.column - 1
    for _, mark in ipairs(v and v.clickables[pos.line] or {}) do
        if mark.col_start <= col and mark.col_end >= col then
            local action = type(mark.actions) == "table" and mark.actions.click or mark.actions
            if type(action) == "function" then
                action()
            elseif type(action) == "string" then
                vim.cmd(action)
            end
            return
        end
    end
end

local function on_left_mouse()
    local pos = vim.fn.getmousepos()
    local win = pos.winid
    if win ~= 0 and api.nvim_win_is_valid(win) and vim.bo[api.nvim_win_get_buf(win)].filetype == "NvMenu" then
        click_menu_item(api.nvim_win_get_buf(win), pos)
        return
    end
    release_mouse()
    require("menu.utils").delete_old_menus()
    -- After the menu's own close handler, which restores the old window and cursor on the next tick.
    vim.schedule(function()
        vim.cmd.exec '"normal! \\<LeftMouse>"'
    end)
end

local function claim_mouse()
    if menus_open() then
        vim.keymap.set("n", "<LeftMouse>", on_left_mouse, { desc = MOUSE_DESC })
    end
end

api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = "NvMenu",
    callback = function(args)
        local win = vim.fn.bufwinid(args.buf)
        if win ~= -1 then
            -- A menu window is exactly as tall as its items. Without scrolloff=0, scrolloff/scrollEOF (cursor on a
            -- nested-menu row) shift the first row out of view.
            vim.wo[win].scrolloff = 0
        end

        -- The cursor is hidden in menus (autocmds.lua), and cursorline does not show because rows are drawn as
        -- overlay virtual text. Keyboard-opened menus mark the cursor row with the same highlight as mouse hover.
        local config = require("menu.state").config
        if not (config and config.mouse) then
            local function hover_cursor_row()
                local w = vim.fn.bufwinid(args.buf)
                if w == -1 then
                    return
                end
                -- Hover ids are "<row>menu<buf>" (menu/ui.lua).
                vim.g.nvmark_hovered = api.nvim_win_get_cursor(w)[1] .. "menu" .. args.buf
                require("volt").redraw(args.buf, "items")
            end
            api.nvim_create_autocmd("CursorMoved", { buffer = args.buf, callback = hover_cursor_row })
            -- After menu.open has drawn the items.
            vim.schedule(hover_cursor_row)
        end
        -- Scheduled: menu.open (also for nested menus) installs the plugin's mapping after setting the filetype.
        vim.schedule(claim_mouse)
    end,
})

api.nvim_create_autocmd("WinClosed", {
    group = group,
    callback = function(args)
        if vim.bo[args.buf].filetype == "NvMenu" then
            vim.schedule(function()
                if not menus_open() then
                    release_mouse()
                end
            end)
        end
    end,
})

-- Scroll events (touchpad during a click) can still move a menu; snap it back to the first row.
api.nvim_create_autocmd("WinScrolled", {
    group = group,
    callback = function()
        for id in pairs(vim.v.event) do
            local win = tonumber(id)
            if win and api.nvim_win_is_valid(win) and vim.bo[api.nvim_win_get_buf(win)].filetype == "NvMenu" then
                api.nvim_win_call(win, function()
                    if vim.fn.line "w0" ~= 1 then
                        vim.fn.winrestview { topline = 1 }
                    end
                end)
            end
        end
    end,
})

--- Concatenate non-empty sections with separators between them. Sections may be nil.
function M.join(...)
    local items = {}
    for i = 1, select("#", ...) do
        local section = select(i, ...)
        if section and #section > 0 then
            if #items > 0 then
                table.insert(items, { name = "separator" })
            end
            vim.list_extend(items, section)
        end
    end
    return items
end

-- Run item commands after the menu has closed, in the window and at the position the menu was opened for.
local function wrap(items, ctx)
    for _, item in ipairs(items) do
        if item.items then
            wrap(item.items, ctx)
        elseif item.cmd then
            local cmd = item.cmd
            item.cmd = function()
                vim.schedule(function()
                    release_mouse()
                    if api.nvim_win_is_valid(ctx.win) then
                        api.nvim_set_current_win(ctx.win)
                        pcall(api.nvim_win_set_cursor, ctx.win, ctx.cursor)
                    end
                    local ok, err = pcall(function()
                        if type(cmd) == "string" then
                            vim.cmd(cmd)
                        else
                            cmd(ctx)
                        end
                    end)
                    if not ok then
                        vim.notify(tostring(err), vim.log.levels.ERROR, { title = "Menu" })
                    end
                end)
            end
        end
    end
    return items
end

local function mouse_in_selection()
    local pos = vim.fn.getmousepos()
    if pos.winid ~= api.nvim_get_current_win() then
        return false
    end
    local a, b = vim.fn.line "v", vim.fn.line "."
    return pos.line >= math.min(a, b) and pos.line <= math.max(a, b)
end

-- Move cursor and focus to the clicked spot and return the clicked window. Done by hand instead of
-- `normal! <RightMouse>` so Neovim's own PopUp menu is never involved. Some windows refuse focus (an autocmd
-- sends it back), so callers use the returned window, not the current one.
local function move_to_mouse()
    local pos = vim.fn.getmousepos()
    if pos.winid == 0 or not api.nvim_win_is_valid(pos.winid) then
        return nil
    end
    if pos.line > 0 then
        pcall(api.nvim_win_set_cursor, pos.winid, { pos.line, math.max(pos.column - 1, 0) })
    end
    pcall(api.nvim_set_current_win, pos.winid)
    return pos.winid
end

local function context(mouse)
    local visual = api.nvim_get_mode().mode:match "^[vV\22]" ~= nil
    if visual then
        -- A right click outside the selection is a normal-mode click there.
        if mouse and not mouse_in_selection() then
            visual = false
        end
        -- Leave visual mode so '< and '> are set; visual items reselect with gv.
        vim.cmd("normal! " .. vim.keycode "<Esc>")
    end
    local win = mouse and not visual and move_to_mouse() or api.nvim_get_current_win()
    -- Entering a window can make a plugin replace it (window ids change).
    if not api.nvim_win_is_valid(win) then
        win = api.nvim_get_current_win()
    end
    local buf = api.nvim_win_get_buf(win)
    return {
        win = win,
        buf = buf,
        ft = vim.bo[buf].filetype,
        cursor = api.nvim_win_get_cursor(win),
        visual = visual,
        mouse = mouse,
    }
end

local function items_for(ctx)
    if ctx.ft == "NvMenu" then
        return nil
    end
    if ctx.ft == "neo-tree" then
        return require "configs.menus.neo-tree"(ctx)
    end
    -- Plugin windows (lazy, trouble, terminals, pickers) get no menu.
    local bt = vim.bo[ctx.buf].buftype
    if bt ~= "" and bt ~= "help" then
        return nil
    end
    if ctx.visual then
        return require "configs.menus.visual"(ctx)
    end
    return require "configs.menus.buffer"(ctx)
end

--- Open the context menu for the window under the mouse (mouse = true) or the current window.
function M.open(mouse)
    require("menu.utils").delete_old_menus()

    local ctx = context(mouse)
    local items = items_for(ctx)
    if not items or #items == 0 then
        return
    end
    require("menu").open(wrap(items, ctx), { mouse = mouse })
end

return M
