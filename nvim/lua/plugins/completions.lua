return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
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
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("plugins.configs.nvim-cmp")
    end,
  }
}
