return {
  -- {
  --   "tpope/vim-fugitive",
  --   keys = {
  --     { "<leader>gs", "<cmd>Git<CR>", silent = true, noremap = true, desc = "Git Status" },
  --     { "<leader>gd", "<cmd>Gdiffsplit<CR>", silent = true, noremap = true, desc = "Git Diff" },
  --     { "<leader>gc", "<cmd>Git commit<CR>", silent = true, noremap = true, desc = "Git Commit" },
  --     { "<leader>gb", "<cmd>Git blame<CR>", silent = true, noremap = true, desc = "Git Blame" },
  --     { "<leader>gl", "<cmd>Git log<CR>", silent = true, noremap = true, desc = "Git Log" },
  --     { "<leader>gp", "<cmd>Git push<CR>", silent = true, noremap = true, desc = "Git Push" },
  --     { "<leader>gP", "<cmd>Git pull<CR>", silent = true, noremap = true, desc = "Git Pull" },
  --     { "<leader>gS", "<cmd>Gstatus<CR>", silent = true, noremap = true, desc = "Git Status" },
  --     { "<leader>gR", "<cmd>Gread<CR>", silent = true, noremap = true, desc = "Git Read" },
  --     { "<leader>gW", "<cmd>Gwrite<CR>", silent = true, noremap = true, desc = "Git Write" },
  --     { "<leader>gB", "<cmd>Gblame<CR>", silent = true, noremap = true, desc = "Git Blame" },
  --     { "<leader>gC", "<cmd>Gcommit<CR>", silent = true, noremap = true, desc = "Git Commit" },
  --     { "<leader>gD", "<cmd>Gdiff<CR>", silent = true, noremap = true, desc = "Git Diff" },
  --     { "<leader>gM", "<cmd>Gmove<CR>", silent = true, noremap = true, desc = "Git Move"
  --   },
  -- },
  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit", "LazyGitConfig" },
    keys = {
      { "<C-g>", "<cmd>LazyGit<CR>", silent = true, noremap = true, desc = "Toggle LazyGit" },
      { "<leader>gg", "<cmd>LazyGit<CR>", silent = true, noremap = true, desc = "Toggle LazyGit" },
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
      {
        "<leader>gn",
        "<cmd>lua require('gitsigns').next_hunk()<CR>",
        silent = true,
        noremap = true,
        desc =
        "Git Next Hunk"
      },
      {
        "<leader>gp",
        "<cmd>lua require('gitsigns').prev_hunk()<CR>",
        silent = true,
        noremap = true,
        desc =
        "Git Previous Hunk"
      },
      {
        "<leader>gb",
        "<cmd>lua require('gitsigns').toggle_current_line_blame()<CR>",
        silent = true,
        noremap = true,
        desc =
        "Git Blame (Current Line)"
      },
      {
        "<leader>gB",
        "<cmd>lua require('gitsigns').toggle_current_line_blame(true)<CR>",
        silent = true,
        noremap = true,
        desc =
        "Git Blame (Current Line, Full)"
      },
      {
        "<leader>gl",
        "<cmd>lua require('gitsigns').blame_line()<CR>",
        silent = true,
        noremap = true,
        desc =
        "Git Blame"
      },
      {
        "<leader>gL",
        "<cmd>lua require('gitsigns').blame_line(true)<CR>",
        silent = true,
        noremap = true,
        desc =
        "Git Blame (Full)"
      },
      {
        "<leader>gp",
        "<cmd>lua require('gitsigns').preview_hunk()<CR>",
        silent = true,
        noremap = true,
        desc =
        "Git Preview Hunk"
      },
      {
        "<leader>gh",
        "<cmd>lua require('gitsigns').reset_hunk()<CR>",
        silent = true,
        noremap = true,
        desc =
        "Git Reset Hunk"
      },
      {
        "<leader>gr",
        "<cmd>lua require('gitsigns').reset_buffer()<CR>",
        silent = true,
        noremap = true,
        desc =
        "Git Reset Buffer"
      },
      {
        "<leader>gs",
        "<cmd>lua require('gitsigns').stage_hunk()<CR>",
        silent = true,
        noremap = true,
        desc =
        "Git Stage Hunk"
      },
      {
        "<leader>gS",
        "<cmd>lua require('gitsigns').stage_buffer()<CR>",
        silent = true,
        noremap = true,
        desc =
        "Git Stage Buffer"
      },
      {
        "<leader>gu",
        "<cmd>lua require('gitsigns').undo_stage_hunk()<CR>",
        silent = true,
        noremap = true,
        desc =
        "Git Unstage Hunk"
      },
      {
        "<leader>gd",
        "<cmd>lua require('gitsigns').diffthis()<CR>",
        silent = true,
        noremap = true,
        desc =
        "Git Diff"
      },
    }
  },
}
