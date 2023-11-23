local is_available = require("utils").is_available
local keymap_utils = require("nvshan.keymap.utils")
local mappings = keymap_utils.init_mapping()
local map = keymap_utils.map

if not is_available("vim-tmux-navigator") then
  vim.notify("Failed to load vim-tmux-navigator", vim.log.levels.WARN)
  return {}
end

mappings.n["<C-h>"] = map(":TmuxNavigateLeft<CR>"):silent():noremap():desc("Tmux Navigate Left")
mappings.n["<C-j>"] = map(":TmuxNavigateDown<CR>"):silent():noremap():desc("Tmux Navigate Down")
mappings.n["<C-k>"] = map(":TmuxNavigateUp<CR>"):silent():noremap():desc("Tmux Navigate Up")
mappings.n["<C-l>"] = map(":TmuxNavigateRight<CR>"):silent():noremap():desc("Tmux Navigate Right")
mappings.n["<C-\\>"] = map(":TmuxNavigatePrevious<CR>"):silent():noremap():desc("Tmux Navigate Previous")

return mappings
