local settings = {}

-- leader key
settings.leader = " "
-- default color scheme to start with
settings.colorscheme = "random"
-- background clolor, "dark" or "light"
settings.background = "dark"
-- plugin file
settings.pluginmodule = "nvshan.plugins"
-- use copilot
settings.use_copilot = true
-- use chatgpt
settings.use_chatgpt = true
-- nvim-tree
settings.float = {
    enable = true,
    height_ratio = 0.8,
    width_ratio = 0.4,
}

return settings
