return {
  -- {
  --   "tpope/vim-fugitive",
  --   keys = {
  --   },
  -- },
  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit", "LazyGitConfig" },
    keys = {
      { "<C-g>",      "<cmd>LazyGit<CR>", desc = "Toggle LazyGit" },
      { "<leader>gg", "<cmd>LazyGit<CR>", desc = "Toggle LazyGit" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("nvshan.plugins.git.gitsigns")
    end,
  },
}
