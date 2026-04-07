local is_transparent = require("settings").transparent
local kanagawa = require("kanagawa")

local overrides = function(colors)
  if is_transparent then
    local theme = colors.theme
    return {
      NormalFloat = { fg = "none" },
      FloatBorder = { fg = "none", bg = "none" },
      FloatTitle = { bg = "none" },

      -- Plugin color groups
      NvimTreeNormal = { bg = "none", fg = "none" },

      -- BoardTelescopeTitle = { fg = theme.ui.special, bold = true },
      TelescopePromptNormal = { bg = "none" },
      TelescopePromptBorder = { bg = "none", fg = theme.ui.bg_m1 },
      TelescopeResultsNormal = { bg = "none", fg = "none" },
      TelescopeResultsBorder = { bg = "none", fg = theme.ui.bg_m1 },
      TelescopePreviewNormal = { bg = "none" },
      TelescopePreviewBorder = { bg = "none", fg = theme.ui.bg_m1 },
    }
  else
    return {}
  end
end

kanagawa.setup({
  compile = false, -- enable compiling the colorscheme
  undercurl = true, -- enable undercurls
  commentStyle = { italic = true },
  functionStyle = {},
  keywordStyle = { italic = true },
  statementStyle = { bold = true },
  typeStyle = {},
  transparent = is_transparent, -- do not set background color
  dimInactive = not is_transparent, -- dim inactive window `:h hl-NormalNC`
  terminalColors = true, -- define vim.g.terminal_color_{0,17}
  colors = { -- add/modify theme and palette colors
    palette = {},
    theme = {
      wave = {},
      lotus = {},
      dragon = {},
      all = {
        ui = {
          bg_gutter = "none",
        },
      },
    },
  },
  overrides = overrides,
  theme = "wave", -- Load "wave" theme when 'background' option is not set
  background = { -- map the value of 'background' option to a theme
    dark = "wave", -- try "dragon" !
    light = "lotus",
  },
})
