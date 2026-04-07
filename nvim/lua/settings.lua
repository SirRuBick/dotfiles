local settings = {}
local global = require("global")
local join_path = require("utils").join_path

-- leader key
settings.leader = " "
-- diagnositc virtual text
settings.diagnostic_virtual_text = false
-- colorscheme, choose from "random" or
-- catppuccin/kanagawa/onedark/gruvbox/nightfox
-- alternative sub-themes are not supported in random, but can be set directly
settings.colorscheme = "onedark"
-- background clolor, "dark" or "light"
settings.background = "dark"
-- trasparent
settings.transparent = true
-- plugin file
settings.pluginmodule = "nvshan.plugins"
-- auto lint
settings.auto_lint = false
-- use copilot
settings.use_copilot = false
-- use codeium
settings.use_codeium = false
-- use chatgpt
settings.use_chatgpt = false
-- nvim-tree
settings.float = {
  enable = true,
  height_ratio = 0.8,
  width_ratio = 0.4,
}
-- DB: dadbod
settings.db_ui_save_location = join_path(global.data_dir, "dadbod")
-- Snippet path
settings.snippets_directory = join_path(global.vim_path, "snippets")
-- Obsidian
settings.obsidian = {
  enable = true,
  vault_path = "~/omnia",
  entry_file = "README.md",
  img_forder = "~/omnia/90.Attachments/images",
  workspaces = { "personal", "work" },
}
-- ident choice
settings.indent_animation = true

return settings
