local is_available = require("utils").is_available
local keymap_utils = require("nvshan.keymap.utils")
local mappings = keymap_utils.init_mapping()
local map = keymap_utils.map

if is_available("nvim-treesitter-context") then
  mappings.n["['"] = map(function()
    require("treesitter-context").go_to_context(vim.v.count1)
  end):desc("Toggle treesitter context")
end

return mappings
