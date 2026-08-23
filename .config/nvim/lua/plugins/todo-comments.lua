return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    { "<leader>ft", "<cmd>Telescope todo-comments<cr>", desc = "Find TODOs" },
  },
  opts = {
    signs = true, 
  },
}
