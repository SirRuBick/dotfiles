local is_available = require("utils").is_available
local keymap_utils = require("nvshan.keymap.utils")
local mappings = keymap_utils.init_mapping()
local map = keymap_utils.map
local db_conf_path = require("settings").db_ui_save_location
local os_sep = require("global").os_path_sep

if not is_available("vim-dadbod") then
  vim.notify("Failed to load dadbod", vim.log.levels.ERROR)
  return {}
end

mappings.n["<leader>qc"] = map("<CMD>DBUIClose<CR>"):desc("Close DB")
mappings.n["<leader>qu"] = map("<CMD>DBUIToggle<CR>"):silent():desc("Toggle DB UI")
mappings.n["<leader>qa"] = map("<CMD>DBUIAddConnection<CR>"):silent():desc("DB Add Connection")
mappings.n["<leader>qf"] = map("<CMD>DBUIFindBuffer<CR>"):silent():desc("DB UI Find Buffer")
mappings.n["<leader>qr"] = map("<CMD>DBUIRenameBuffer<CR>"):silent():desc("DB UI Rename Buffer")
mappings.n["<leader>qq"] = map("<CMD>DBUILastQueryInfo<CR>"):silent():desc("Last Query Info")
mappings.n["<leader>qe"] = map("<CMD>e " .. db_conf_path .. os_sep .. "connections.json<CR>"):silent():desc("Edit DB Connection Config")

return mappings
