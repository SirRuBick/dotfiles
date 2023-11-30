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
    },
    config = require "nvshan.plugins.lsp.nvim-lsp",
  },
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require "nvshan.plugins.lsp.lspsaga"
    end,
  },
}
