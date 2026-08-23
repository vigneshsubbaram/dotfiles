return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    spec = {
      -- Group names for your leader keys
      { "<leader>a", group = "AI (Sidekick/agy)", mode = { "n", "x", "v" } },
      { "<leader>f", group = "File / Find / Format" },
      { "<leader>c", group = "Code / CoC" },
      { "<leader>h", group = "Git / Hunks" },
      { "<leader>m", group = "Markdown" },
      
      -- Standard key groups
      { "g", group = "Goto / Navigation" },
      
      -- If you highlight text and press 'Space', group names for visual mode
      { "<leader>f", group = "Format", mode = "v" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
