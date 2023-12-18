return {
  {
    "williamboman/mason.nvim",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
    },
    build = ":MasonUpdate",
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    -- lazy=false,
    dependencies = {
      {
        "williamboman/mason-lspconfig.nvim",
        config = function()
          require "nvshan.plugins.lsp.mason-lspconfig"
        end,
      },
      {
        "folke/neodev.nvim",
        config = true,
      },
      {
        "joechrisellis/lsp-format-modifications.nvim",
      },
      {
        "nvimdev/lspsaga.nvim",
        dependencies = {
          "nvim-tree/nvim-web-devicons",
        },
        config = function()
          require "nvshan.plugins.lsp.lspsaga"
        end,
      },
    },
    config = require "nvshan.plugins.lsp.nvim-lsp",
  },
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" ,"BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
      require("nvshan.plugins.lsp.conform")
    end,
  },
}
