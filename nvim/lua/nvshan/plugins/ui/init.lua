local settings = require("settings")

local plugins = {
  {
    "akinsho/bufferline.nvim",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvshan.plugins.ui.bufferline")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    cmd = "LualineToggle",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvshan.plugins.ui.lualine")
    end,
  },
  {
    "utilyre/barbecue.nvim",
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
    tag = "stable",
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
    -- NOTE: Disable lazy load for notifying random colorscheme at the start
    -- lazy = false,
    event = "VeryLazy",
    config = function()
      require("nvshan.plugins.ui.notify")
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    cond = not settings.indent_animation,
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvshan.plugins.ui.ibl")
    end,
  },
  {
    "echasnovski/mini.indentscope",
    cond = settings.indent_animation,
    version = "*",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      mappings = {
        -- Textobjects
        object_scope = "ip",
        object_scope_with_border = "ap",
        -- Motions (jump to respective border line; if not present - body line)
        goto_top = "[p",
        goto_bottom = "]p",
      },
    },
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {},
  }
}

return plugins
