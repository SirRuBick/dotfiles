return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "nvim-telescope/telescope-dap.nvim",
    "jay-babu/mason-nvim-dap.nvim",
    "theHamsta/nvim-dap-virtual-text",
    {
      "rcarriga/nvim-dap-ui",
      opts = { floating = { border = "rounded" } },
      config = function()
        require("plugins.configs.dap-ui")
      end,
    },
  },
}
