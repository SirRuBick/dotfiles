return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "onsails/lspkind.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "andersevenrud/cmp-tmux",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      {
        "L3MON4D3/LuaSnip",
        build = vim.fn.has "win32" == 0 and
            "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp" or nil,
        dependencies = {
          "rafamadriz/friendly-snippets",
        },
      },
    },
    config = function()
      require("nvshan.plugins.completion.config")
    end,
  },
}