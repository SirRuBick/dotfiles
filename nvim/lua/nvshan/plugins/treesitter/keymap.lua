local is_available = require("utils").is_available
local maps = require("nvshan.keymap.utils").init_mapping()
local map = keymap_utils.map

if is_available("treesitter-context") then
    maps.n["[c"] = map(require("treesitter-context").go_to_context):silent():noremap():desc("Toggle treesitter context")
end

return maps