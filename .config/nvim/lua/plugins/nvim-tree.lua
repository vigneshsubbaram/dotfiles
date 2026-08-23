return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("nvim-tree").setup({
            view = {
                width = 30, 
                side = "left",
            },
            renderer = {
                group_empty = true,   -- Group empty folders together
                highlight_git = true, -- Color files based on Git status (modified, untracked)
            },
            filters = {
                dotfiles = false, 
            },
        })

        -- Toggle the explorer with Space + e
        vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true, desc = "Toggle Explorer" })
        
        -- Automatically locate and highlight the currently open file in the tree
        vim.keymap.set("n", "<leader>fe", ":NvimTreeFindFile<CR>", { silent = true, desc = "Focus current file in tree" })
    end
}
