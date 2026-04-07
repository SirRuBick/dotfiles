require("illuminate").configure({
  providers = {
    "lsp",
    "treesitter",
    "regex",
  },
  delay = 100,
  filetypes_denylist = {
    "DoomInfo",
    "DressingSelect",
    "NvimTree",
    "Outline",
    "TelescopePrompt",
    "Trouble",
    "alpha",
    "dashboard",
    "dirvish",
    "fugitive",
    "help",
    "lsgsagaoutline",
    "neogitstatus",
    "norg",
    "toggleterm",
    "Navbuddy",
    "Outline",
  },
  -- under_cursor: whether or not to illuminate under the cursor
  under_cursor = false,
  -- large_file_cutoff: number of lines at which to use large_file_config
  -- The `under_cursor` option is disabled when this cutoff is hit
  large_file_cutoff = 10000,
})
