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
    dependencies = {
      {
        "williamboman/mason-lspconfig.nvim",
        config = function()
          require("nvshan.plugins.lsp.mason-lspconfig")
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
    config = function()
      require("nvshan.plugins.lsp.nvim-lsp")
    end,
  },
  {
    -- lazy loaded by lsp-config
    "mfussenegger/nvim-lint",
    priority = 10,
    config = function()
      require("nvshan.plugins.lsp.nvim-lint")
    end,
  },
  {
    -- lazy loaded by lsp-config
    "stevearc/conform.nvim",
    config = function()
      require("nvshan.plugins.lsp.conform")
    end,
  },
  {
    "SmiteshP/nvim-navbuddy",
    cmd = { "Navbuddy" },
    dependencies = {
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("nvshan.plugins.lsp.nvim-navbuddy")
    end,
  },
  {
    "nvimdev/lspsaga.nvim",
    cond = false,
    event = "LspAttach",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvshan.plugins.lsp.lspsaga")
    end,
  },
  {
    "hedyhli/outline.nvim",
    event = "LspAttach",
    opts = {},
  },
}
