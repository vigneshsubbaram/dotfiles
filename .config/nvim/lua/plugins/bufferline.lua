return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        require("bufferline").setup({
            options = {
                numbers = "ordinal", 
                diagnostics = "coc", 
                separator_style = "slant", 
                show_buffer_close_icons = false, 
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        highlight = "Directory",
                        separator = true
                    }
                }
            }
        })

        -- Use Space + 1 through 9 to jump to specific tabs
        for i = 1, 9 do
            vim.keymap.set('n', '<leader>' .. i, '<Cmd>BufferLineGoToBuffer ' .. i .. '<CR>', { 
                silent = true, 
                desc = 'Go to tab ' .. i 
            })
        end

        -- Space + c to close the current tab
        vim.keymap.set('n', '<leader>c', ':bdelete<CR>', { 
            silent = true, 
            desc = 'Close current tab' 
        })
        
        -- Use Shift+H and Shift+L to quickly slide left and right between tabs
        vim.keymap.set('n', '<S-h>', ':BufferLineCyclePrev<CR>', { silent = true })
        vim.keymap.set('n', '<S-l>', ':BufferLineCycleNext<CR>', { silent = true })
    end
}
