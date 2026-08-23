return {
    "rmagatti/auto-session",
    config = function()
        require("auto-session").setup({
            suppressed_dirs = {
                "~/",
                "~/Downloads",
                "/",
                "/tmp",
            },

            auto_save = true,
            auto_restore = true,
            auto_create = true,

            -- Don't save these as regular session buffers.
            close_filetypes_on_save = {
                "checkhealth",
                "NvimTree",
            },

            -- Close NvimTree before saving the session.
            pre_save_cmds = {
                "tabdo NvimTreeClose",
            },
        })

        -- Session management
        vim.keymap.set("n", "<leader>ss", "<Cmd>SessionSearch<CR>", {
            desc = "Search saved sessions",
        })

        vim.keymap.set("n", "<leader>sd", "<Cmd>SessionDelete<CR>", {
            desc = "Delete current session",
        })
    end,
}

