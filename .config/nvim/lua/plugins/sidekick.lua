return {
  "folke/sidekick.nvim",
  opts = {
    cli = {
      tools = {
        antigravity = {
          cmd = { "agy", "--model", "gemini-3.1-pro-high" },
        },
        agy_deep_think = {
          cmd = { "agy", "--effort", "high", "--model", "gemini-3.7-flash-high" },
        },
        agy_sandbox = {
          cmd = { "agy", "--sandbox", "--model", "gemini-3.1-pro-high" },
        },
      }
    }
  },
  keys = {
    -- Use this to initially start the 'agy' CLI
    { "<leader>as", function() require("sidekick.cli").select() end, desc = "Select Sidekick CLI" },
    
    -- TOGGLE: hide/show the CLI window. 
    -- Adding "t" allows you to press <leader>at directly while typing in the agy chat!
    { "<leader>at", function() require("sidekick.cli").toggle() end, mode = { "n", "t", "v" }, desc = "Toggle Sidekick CLI" },

    -- SEND CONTEXT: Select a block of text in visual mode and press <leader>ac
    -- This dumps the code into agy, allowing you to manually type your question after.
    { 
      "<leader>ac", 
      function() require("sidekick.cli").send({ msg = "{selection}" }) end, 
      mode = { "x" }, 
      desc = "Send selection to agy" 
    },

    -- PROMPT + SEND CONTEXT: Select a block of text, press <leader>aa.
    -- Neovim will ask you for your question at the bottom of the screen, 
    -- then send BOTH your question and the code context to agy at once.
    { 
      "<leader>aa", 
      function() 
        local input = vim.fn.input("Ask agy about code: ")
        if input ~= "" then
          require("sidekick.cli").send({ msg = input .. "\n\n{selection}" })
        end
      end, 
      mode = { "x" }, 
      desc = "Prompt and send selection" 
    },
  }
}

