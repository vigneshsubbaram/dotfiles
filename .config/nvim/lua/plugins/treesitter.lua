return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false, -- does not support lazy-loading
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").install({
            "bash", "c", "go", "lua", "markdown",
            "markdown_inline", "python", "tsx",
            "typescript", "vim", "vimdoc", "yaml"
        })

        -- Highlighting is no longer a plugin setting. 
        -- tell Neovim natively to start it for all files.
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "*",
            callback = function()
                -- pcall prevents errors on filetypes that don't have parsers
                pcall(vim.treesitter.start)
            end,
        })

        -- Folds
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "*",
            callback = function()
                vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
                vim.wo[0][0].foldmethod = "expr"
            end,
        })
    end,
}
