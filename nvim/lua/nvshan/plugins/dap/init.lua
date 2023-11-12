return {
  {
    "mfussenegger/nvim-dap",
    cmd = {
      "DapSetLogLevel",
      "DapShowLog",
      "DapContinue",
      "DapToggleBreakpoint",
      "DapToggleRepl",
      "DapStepOver",
      "DapStepInto",
      "DapStepOut",
      "DapTerminate",
    },
    dependencies = {
      -- "nvim-telescope/telescope-dap.nvim",
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = { "williamboman/mason.nvim" },
      },
      {
        "theHamsta/nvim-dap-virtual-text",
        config = function()
          require("nvshan.plugins.dap.dap-virtual-text")
        end,
      },
      {
        "rcarriga/nvim-dap-ui",
        config = function()
          require("nvshan.plugins.dap.dap-ui")
        end,
      },
    },
    config = function()
      require("nvshan.plugins.dap.dap")
    end,
  }
}

