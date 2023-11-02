return {
  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.1",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-media-files.nvim",
      "nvim-telescope/telescope-fzy-native.nvim",
    },
    config = function()
      require("nvshan.plugins.telescope.config")
    end,
    -- keys = {
    --   { "<leader>gb", "<cmd>Telescope git_branches<cr>", silent=true, noremap=false, desc = "Git Branches" },
    --   { "<leader>gc", "<cmd>Telescope git_branches<cr>", silent=true, noremap=false, desc = "Git Commits" },
    --   { "<leader>gs", "<cmd>Telescope git_branches<cr>", silent=true, noremap=false, desc = "Git Status" },
    --   { "<leader>ff", "<cmd>Telescope find_files<cr>", silent=true, noremap=false, desc = "Find Files" },
    --   { "<leader>fw", "<cmd>Telescope live_grep<cr>", silent=true, noremap=false, desc = "Find Words" },
    --   { "<leader>fW", "<cmd>lua require('telescope.builtin').live_grep({additional_args = {'--hidden', '--no-ignore'}})<cr>", silent=true, noremap=false, desc = "Find Words (All Files)" },
    --   { "<leader>fb", "<cmd>Telescope buffers<cr>", silent=true, noremap=false, desc = "Find Buffers" },
    --   { "<leader>fk", "<cmd>Telescope keymaps<cr>", silent=true, noremap=false, desc = "Find Keymaps" },
    --   { "<leader>fo", "<cmd>Telescope oldfiles<cr>", silent=true, noremap=false, desc = "Find History" },
    --   { "<leader>ft", "<cmd>Telescope colorscheme<cr>", silent=true, noremap=false, desc = "Find Themes" },
    --   { "<leader>fc", "<cmd>Telescope grep_string<cr>", silent=true, noremap=false, desc = "Find Word Under Cursor" },
    --   { "<leader>fr", "<cmd>Telescope resume<cr>", silent=true, noremap=false, desc = "Resume Last Find" },
    --   { "<leader>lD", "<cmd>Telescope diagnostics<cr>", silent=true, noremap=false, desc = "Search diagnostics" },
    -- },
  },
}
