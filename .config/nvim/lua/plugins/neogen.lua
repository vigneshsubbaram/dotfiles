return {
    "danymat/neogen",
    dependencies = { 
        "nvim-treesitter/nvim-treesitter",
        "L3MON4D3/LuaSnip"
    }, 
    config = function()
        require("neogen").setup({
            snippet_engine = "luasnip",
            languages = {
                python = {
                    template = {
                        annotation_convention = "reST", 
                    }
                }
            }
        })

       vim.keymap.set("n", "<leader>d", function()
            require("neogen").generate()
        end, { desc = "Generate Docstring" }) 
    end,
}
