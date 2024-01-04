local settings = {}
local global = require("global")
local join_path = require("utils").join_path

-- leader key
settings.leader = " "
-- colorscheme, choose from random or
-- tokyonight/catppuccin/kanagawa/onedark/gruvbox
settings.colorscheme = "catppuccin"
-- background clolor, "dark" or "light"
settings.background = "dark"
-- trasparent
settings.transparent = true
-- plugin file
settings.pluginmodule = "nvshan.plugins"
-- use copilot
settings.use_copilot = true
-- use chatgpt
settings.use_chatgpt = false
-- nvim-tree
settings.float = {
  enable = not settings.transparent,
  height_ratio = 0.8,
  width_ratio = 0.4,
}
-- DB: dadbod
settings.db_ui_save_location = join_path(global.data_dir, "dadbod")

return settings
