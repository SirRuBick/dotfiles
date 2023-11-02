local settings = {}

-- default color scheme to start with
settings.colorscheme = "catppuccin"
-- background clolor, "dark" or "light"
settings.background = "dark"
-- plugin file
settings.pluginmodule = "nvshan.plugins"
-- use copilot
settings.use_copilot = false
-- nvim-tree
settings.float = {
    enable = false,
    height_ratio = 0.8,
    width_ratio = 0.4,
}

return settings
