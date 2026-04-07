local utils = require("nvshan.keymap.utils")
local pluginmodule = require("settings").pluginmodule
local mappings = require("nvshan.keymap.mapping")

mappings = utils.merge_keymap(mappings, pluginmodule)

utils.load_keymaps(mappings)
