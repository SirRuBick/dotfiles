return {
  -- git
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("plugins.configs.gitsigns")
    end,
  },
  {
    "tpope/vim-fugitive",
  },
  {
    "kdheepak/lazygit.nvim",
  },
}
