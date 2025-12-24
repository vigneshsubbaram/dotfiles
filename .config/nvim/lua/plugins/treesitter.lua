return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
	local configs = require("nvim-treesitter.configs")
	configs.setup({
	    highlight = {
		enable = true,
	    },
	    indent = { enable = true },
	    autotage = { enable = true },
	    ensure_installed = { "markdown", "markdown_inline", "lua", "python", "tsx", "typescript", "go", "yaml" },
	    auto_install = false
	})
    end
}
