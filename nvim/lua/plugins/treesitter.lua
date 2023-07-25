return {
  -- Tree sitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "windwp/nvim-ts-autotag",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "p00f/nvim-ts-rainbow",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("plugins.configs.treesitter")
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("plugins.configs.autopairs")
    end,
  },
}

