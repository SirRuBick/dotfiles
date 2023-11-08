local plugins = {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    "rhysd/accelerated-jk",
    keys = {
      { "j", "<Plug>(accelerated_jk_gj)" },
      { "k", "<Plug>(accelerated_jk_gk)" },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o",               function() require("flash").remote() end,     desc = "Remote Flash" },
      {
        "R",
        mode = { "o", "x" },
        function() require("flash").treesitter_search() end,
        desc =
        "Treesitter Search"
      },
      {
        "<c-s>",
        mode = { "c" },
        function() require("flash").toggle() end,
        desc =
        "Toggle Flash Search"
      },
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    commands = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigateNext",
      "TmuxNavigateLast",
    },
    keys = {
      { "n", "<C-h>",  ":TmuxNavigateLeft<CR>" },
      { "n", "<C-j>",  ":TmuxNavigateDown<CR>" },
      { "n", "<C-k>",  ":TmuxNavigateUp<CR>" },
      { "n", "<C-l>",  ":TmuxNavigateRight<CR>" },
      { "n", "<C-\\>", ":TmuxNavigatePrevious<CR>" },
      { "n", "<C-]>",  ":TmuxNavigateNext<CR>" },
      { "n", "<C-/>",  ":TmuxNavigateLast<CR>" },
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle" },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<CR>", silent = true, noremap = true, desc = " Explorer" },
    },
    config = function()
      require("nvshan.plugins.editor.nvim-tree")
    end,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = vim.opt.sessionoptions:get() },
    -- stylua: ignore
    keys = {
      { "<leader>ss", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>sr", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>sq", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },
}

return plugins
