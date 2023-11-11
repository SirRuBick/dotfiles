local use_chatgpt = require("settings").use_chatgpt

return {
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
  {
      "jackMort/ChatGPT.nvim",
      cond = use_chatgpt,
      command = { "ChatGPT", "ChatGPTActAs", "ChatGPTEditWithInstructions", "ChatGPTRun" },
      dependencies = {
          "MunifTanjim/nui.nvim",
          "nvim-lua/plenary.nvim",
          "nvim-telescope/telescope.nvim"
      },
      config = function()
          require("nvshan.plugins.extras.chatgpt")
      end,
  },
}

