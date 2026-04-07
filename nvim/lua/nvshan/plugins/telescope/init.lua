return {
  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-media-files.nvim",
      "nvim-telescope/telescope-fzy-native.nvim",
      "debugloop/telescope-undo.nvim",
    },
    config = function()
      require("nvshan.plugins.telescope.config")
    end,
  },
}
