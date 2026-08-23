return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },

    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "c", "lua", "vim", "vimdoc", "query", "markdown", 
                "markdown_inline", "python", "tsx", "typescript", 
                "go", "yaml", "bash" 
            },

            highlight = { 
                enable = true,
            },

            indent = { 
                enable = true,
            },

            textobjects = {
                select = {
                    enable = true,
                    lookahead = true, 
                    keymaps = {
                        ["af"] = { query = "@function.outer", desc = "Select outer part of a function" },
                        ["if"] = { query = "@function.inner", desc = "Select inner part of a function" },
                        ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
                        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
                    },
                },
            },
        })
    end,
}
