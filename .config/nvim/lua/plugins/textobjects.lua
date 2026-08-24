return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
        require("nvim-treesitter-textobjects").setup({
            select = {
                lookahead = true,
                include_surrounding_whitespace = false,
            },
        })

        local select = require("nvim-treesitter-textobjects.select")

        vim.keymap.set({ "x", "o" }, "af", function()
            select.select_textobject("@function.outer", "textobjects")
        end, { desc = "Select outer part of a function" })

        vim.keymap.set({ "x", "o" }, "if", function()
            select.select_textobject("@function.inner", "textobjects")
        end, { desc = "Select inner part of a function" })

        vim.keymap.set({ "x", "o" }, "ac", function()
            select.select_textobject("@class.outer", "textobjects")
        end, { desc = "Select outer part of a class" })

        vim.keymap.set({ "x", "o" }, "ic", function()
            select.select_textobject("@class.inner", "textobjects")
        end, { desc = "Select inner part of a class" })
    end,
}
