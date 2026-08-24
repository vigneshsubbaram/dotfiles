vim.opt.number = true
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.winborder = 'rounded'

vim.opt.tabstop = 4      -- A tab character has 4 spaces
vim.opt.softtabstop = 4  -- Pressing the Tab key inserts 4 spaces
vim.opt.expandtab = true -- Convert all tabs to actual spaces

-- Decrease update time so the hover window shows up instantly (default is 4000ms)
vim.opt.updatetime = 300

-- use the system clipboard
vim.opt.clipboard = "unnamedplus"

-- Customize how errors are displayed
vim.diagnostic.config({
    virtual_text = false, -- Turn off right-side text
    signs = true,         -- Show icons in the gutter on the left
    underline = true,     -- Underline the exact word causing the error
    update_in_insert = false,
})

-- Automatically show the error popup when resting the cursor on a line
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil, { focus = false, border = "rounded" })
    end,
})

-- When opening a new file, leave all the folds open.
vim.opt.foldlevelstart = 99

