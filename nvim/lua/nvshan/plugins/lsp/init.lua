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
    lazy = false,
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
    },
    config = require "nvshan.plugins.lsp.lspconfig",
  },
}
