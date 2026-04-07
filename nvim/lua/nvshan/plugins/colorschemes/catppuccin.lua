local is_transparent = require("settings").transparent

local overrides = function(colors)
  if is_transparent then
    return {
      -- NOTE: nvim-tree floating window doesn't like none bg,
      -- it's making the window bg even darker
      NormalFloat = { fg = colors.none, bg = colors.none },
      FloatBorder = { fg = colors.none, bg = colors.none },
      FloatTitle = { bg = colors.none },
    }
  else
    return {}
  end
end

require("catppuccin").setup({
  flavour = "mocha", -- latte, frappe, macchiato, mocha
  background = { -- :h background
    light = "latte",
    dark = "mocha",
  },
  custom_highlights = overrides,
  transparent_background = is_transparent,
  dim_inactive = {
    enabled = not is_transparent,
    shade = nil,
    percentage = 0.5,
  },
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
      dap = true,
      dap_ui = true,
      flash = true,
      gitsigns = true,
      indent_blankline = {
        enabled = true,
        scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
        colored_indent_levels = false,
      },
      illuminate = true,
      lsp_trouble = true,
      markdown = true,
      mason = true,
      notify = true,
      noice = false,
      nvimtree = true,
      ufo = true,
      symbols_outline = false,
      telescope = true,
      treesitter_context = false,
      treesitter = true,
      which_key = false,
    },
  },
})
