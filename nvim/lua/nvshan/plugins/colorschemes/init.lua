local enable_transparent = require("settings").transparent

return {
  {
    -- catpuccin
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("nvshan.plugins.colorschemes.catppuccin")
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    config = function()
      require("nvshan.plugins.colorschemes.kanagawa")
    end,
  },
  {
    "navarasu/onedark.nvim",
    name = "onedark",
    config = function()
      require("nvshan.plugins.colorschemes.onedark")
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    config = function()
      require("nvshan.plugins.colorschemes.gruvbox")
    end,
  },
  {
    "EdenEast/nightfox.nvim",
    name = "nightfox",
    config = function()
      require("nvshan.plugins.colorschemes.nightfox")
    end,
  },
}
