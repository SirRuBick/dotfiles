local plugins = {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    dependencies = "nvim-tree/nvim-web-devicons",
    config = {}
  },
  {
    "nvim-lualine/lualine.nvim",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    command = "LualineToggle",

    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require("nvshan.plugins.ui.lualine")
    end,
  },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      theme = "catppuccin",
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("nvshan.plugins.ui.noice")
    end,
  },
  {
    "rcarriga/nvim-notify",
    lazy = false,
    config = function()
      local notify = require("notify")
      notify.setup({
        -- Animation style
        stages = "fade_in_slide_out",
        -- Default timeout for notifications
        timeout = 1500,
        background_colour = "#2E3440",
      })
      vim.notify = notify
    end,
  },
  {
    "edluffy/specs.nvim",
    event = "CursorMoved",
    config = function()
      require("nvshan.plugins.ui.specs")
    end
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    config = function()
      require("nvshan.plugins.ui.ibl")
    end,
  },
  {
    "petertriho/nvim-scrollbar",
    event = { "BufNewFile", "BufReadPost" },
    dependencies = {
      "lewis6991/gitsigns.nvim",
      {
        "kevinhwang91/nvim-hlslens",
        config = function()
          require("scrollbar.handlers.search").setup({})
        end
      },
    },
    opts = {},
  },
}

return plugins
