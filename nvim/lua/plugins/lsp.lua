return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
      { "folke/neodev.nvim",  opts = {} },
      {
        "williamboman/mason-lspconfig.nvim",
        config = function()
          require "plugins.configs.mason-lspconfig"
        end,
      },
    },
    config = require "plugins.configs.lsp.lspconfig",
  },
}
