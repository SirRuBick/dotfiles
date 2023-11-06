return {
  -- {
  --   "tpope/vim-fugitive",
  --   keys = {
  --     { "<leader>gs", "<cmd>Git<CR>",   desc = "Git Status" },
  --     { "<leader>gd", "<cmd>Gdiffsplit<CR>",   desc = "Git Diff" },
  --     { "<leader>gc", "<cmd>Git commit<CR>",   desc = "Git Commit" },
  --     { "<leader>gb", "<cmd>Git blame<CR>",   desc = "Git Blame" },
  --     { "<leader>gl", "<cmd>Git log<CR>",   desc = "Git Log" },
  --     { "<leader>gp", "<cmd>Git push<CR>",   desc = "Git Push" },
  --     { "<leader>gP", "<cmd>Git pull<CR>",   desc = "Git Pull" },
  --     { "<leader>gS", "<cmd>Gstatus<CR>",   desc = "Git Status" },
  --     { "<leader>gR", "<cmd>Gread<CR>",   desc = "Git Read" },
  --     { "<leader>gW", "<cmd>Gwrite<CR>",   desc = "Git Write" },
  --     { "<leader>gB", "<cmd>Gblame<CR>",   desc = "Git Blame" },
  --     { "<leader>gC", "<cmd>Gcommit<CR>",   desc = "Git Commit" },
  --     { "<leader>gD", "<cmd>Gdiff<CR>",   desc = "Git Diff" },
  --     { "<leader>gM", "<cmd>Gmove<CR>",   desc = "Git Move"
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
    keys = {
      -- Navigation
      { "]h", function() require("gitsigns").next_hunk() end, desc = "Git Next Hunk" },
      { "[h", function() require("gitsigns").prev_hunk() end, desc = "Git Previous Hunk" },
      { "gn", function() require("gitsigns").next_hunk() end, desc = "Git Next Hunk ([h)" },
      { "gp", function() require("gitsigns").prev_hunk() end, desc = "Git Previous Hunk ([h)" },
      -- Actions
      { "<leader>gs", function() require("gitsigns").stage_hunk() end, mode = { "n", "v" }, desc = "Git Stage Hunk" },
      { "<leader>gu", function() require("gitsigns").undo_stage_hunk() end, desc = "Git Unstage Hunk" },
      { "<leader>gr", function() require("gitsigns").reset_hunk() end, mode = { "n", "v" }, desc = "Git Reset Hunk" },
      { "<leader>gS", function() require("gitsigns").stage_buffer() end, desc = "Git Stage Buffer" },
      { "<leader>gR", function() require("gitsigns").reset_buffer() end, desc = "Git Reset Buffer" },
      { "<leader>gb", function() require("gitsigns").toggle_current_line_blame() end, desc = "Git Blame (Current Line)" },
      { "<leader>gB", function() require("gitsigns").blame_line({full=true}) end, desc = "Git Blame" },
      { "<leader>gd", function() require("gitsigns").diffthis() end, desc = "Git Diff" },
      { "<leader>gD", function() require("gitsigns").diffthis('~') end, desc = "Git Diff All" },
      { "<leader>gU", function() require("gitsigns").toggle_deleted() end, desc = "Git Toggle Deleted" },
      -- Text Object
      { "ih", ":<C-U>Gitsigns select_hunk<CR>", mode = { "o", "x" }, desc = "Select in hunk"},
    }
  },
}
