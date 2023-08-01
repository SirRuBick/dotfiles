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
      transparent_background = false,
      show_end_of_buffer = true,       -- show the '~' characters after the end of buffers
      integrations = {
        alpha = true,
        barbecue = {
          dim_dirname = true,     -- directory name is dimmed by default
          bold_basename = true,
          dim_context = false,
          alt_background = false,
          indent_blankline = {
            enabled = true,
            colored_indent_levels = false,
          },
        cmp = true,
        flash = true,
        gitsigns = true,
        illuminate = true,
        lsp_trouble = true,
        mason = true,
        mini = true,
        notify = false,
        neotree = true,
        telescope = true,
        treesitter = true,
        which_key = true,
        },
      },
    },
  },
}
