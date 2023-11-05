return {
  -- Tree sitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufRead", "BufNewFile" },
    commands = {
      "TSInstall",
      "TSInstallSync",
      "TSUpdate",
      "TSUpdateSync",
      "TSUninstall",
      "TSUninstallSync",
    },
    dependencies = {
      -- "nvim-treesitter/nvim-treesitter-refactor", -- seems bit duplicate with lsp
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
      "HiPhish/nvim-ts-rainbow2",
      "windwp/nvim-ts-autotag",
    },
    config = function()
      require("nvshan.plugins.treesitter.config")
    end,
  },
}
