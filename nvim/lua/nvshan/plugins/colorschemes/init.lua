local enable_transparent = require("settings").transparent

return {
  {
    -- tokyonight-night, tokyonight-storm, tokyonight-day, tokyonight-moon
    "folke/tokyonight.nvim",
    name = "tokyonight",
    opts = {
      style = "moon",
      transparent = enable_transparent,
    },
  },
  {
    -- catpuccin
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = {     -- :h background
        light = "latte",
        dark = "mocha",
      },
      transparent_background = enable_transparent,
      show_end_of_buffer = true, -- show the "~" characters after the end of buffers
      integrations = {
        alpha = true,
        barbecue = {
          dim_dirname = true, -- directory name is dimmed by default
          bold_basename = true,
          dim_context = false,
          alt_background = false,
          indent_blankline = {
            enabled = true,
            scope_color = "lavender", -- catppuccin color (eg. `lavender`) Default: text
            colored_indent_levels = true,
          },
          cmp = true,
          flash = true,
          gitsigns = true,
          illuminate = true,
          lsp_trouble = true,
          mason = true,
          mini = true,
          notify = true,
          neotree = true,
          telescope = true,
          treesitter_context = false,
          treesitter = true,
          which_key = true,
        },
      },
    },
  },
  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    opts = {
      compile = false,  -- enable compiling the colorscheme
      undercurl = true, -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = enable_transparent, -- do not set background color
      dimInactive = false,              -- dim inactive window `:h hl-NormalNC`
      terminalColors = true,            -- define vim.g.terminal_color_{0,17}
      colors = {                        -- add/modify theme and palette colors
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
      },
      overrides = function(colors) -- add/modify highlights
        return {}
      end,
      theme = "wave",  -- Load "wave" theme when 'background' option is not set
      background = {   -- map the value of 'background' option to a theme
        dark = "wave", -- try "dragon" !
        light = "lotus"
      },
    },
  },
  {
    "navarasu/onedark.nvim",
    name = "onedark",
    opts = {
      -- Main options --
      style = 'dark',                   -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
      transparent = enable_transparent, -- Show/hide background
      term_colors = true,               -- Change terminal color as per the selected theme style
      ending_tildes = false,            -- Show the end-of-buffer tildes. By default they are hidden
      cmp_itemkind_reverse = false,     -- reverse item kind highlights in cmp menu

      -- toggle theme style ---
      toggle_style_key = nil,                                                              -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
      toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' }, -- List of styles to toggle between

      -- Change code style ---
      -- Options are italic, bold, underline, none
      -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
      code_style = {
        comments = 'italic',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none'
      },

      -- Lualine options --
      lualine = {
        transparent = enable_transparent, -- lualine center bar transparency
      },

      -- Custom Highlights --
      colors = {},     -- Override default colors
      highlights = {}, -- Override highlight groups

      -- Plugins Config --
      diagnostics = {
        darker = true,     -- darker colors for diagnostic
        undercurl = true,  -- use undercurl instead of underline for diagnostics
        background = true, -- use background color for virtual text
      },
    },
  },
  {
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    opts = {
      transparent_mode = enable_transparent,
    },
  },
}
