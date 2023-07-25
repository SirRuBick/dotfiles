return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    init = function() vim.g.neo_tree_remove_legacy_commands = true end,
    config = function()
      require("plugins.configs.neo-tree")
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    "christoomey/vim-tmux-navigator",
  },
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
  },
}
