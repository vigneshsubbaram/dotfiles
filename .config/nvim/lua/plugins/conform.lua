return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      -- Trigger formatting
      "<leader>fm",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
  },
  opts = {
    -- Map file types to formatters
    formatters_by_ft = {
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      xml = { "xmlformat" }, 
      python = { "ruff" },
      sh = { "shfmt" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
    formatters = {
      prettier = {
	    prepend_args = { "--tab-width", "4" },
      },
      shfmt = {
        prepend_args = { "-i", "4" },
      },
    },
  },
}
