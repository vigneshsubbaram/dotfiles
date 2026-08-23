return {
  "fannheyward/telescope-coc.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("telescope").load_extension("coc")
  end,
  keys = {
    { "<leader>cd", "<cmd>Telescope coc definitions<cr>", desc = "Telescope CoC Definitions" },
    { "<leader>cr", "<cmd>Telescope coc references<cr>", desc = "Telescope CoC References" },
    { "<leader>ce", "<cmd>Telescope coc diagnostics<cr>", desc = "Telescope CoC Diagnostics (Errors)" },
  },
}

