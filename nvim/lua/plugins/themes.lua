return {
  {
    -- tokyonight-night, tokyonight-storm, tokyonight-day, tokyonight-moon
    "folke/tokyonight.nvim",
    opts = { style = "moon" },
  },
  {
    -- catpuccin
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "mocha",       -- latte, frappe, macchiato, mocha
      background = {           -- :h background
        light = "latte",
        dark = "mocha",
      },
      transparent_background = true,
      show_end_of_buffer = true,       -- show the '~' characters after the end of buffers
      integrations = {
        cmp = true,
        gitsigns = true,
        treesitter = true,
        barbecue = {
          dim_dirname = true,     -- directory name is dimmed by default
          bold_basename = true,
          dim_context = false,
          alt_background = false,
          indent_blankline = {
            enabled = true,
            colored_indent_levels = false,
          },
        },
      },
    },
  },
}
