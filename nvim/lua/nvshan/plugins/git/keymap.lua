local is_available = require("utils").is_available
local keymap_utils = require("nvshan.keymap.utils")
local mappings = keymap_utils.init_mapping()
local map = keymap_utils.map


if is_available("telescope.nvim") then
  mappings.n["<leader>gb"] = map(function() require("telescope.builtin").git_branches() end):silent():desc("Search git branches")
  mappings.n["<leader>gc"] = map(function() require("telescope.builtin").git_commits() end):silent():desc("Search Git commits")
  mappings.n["<leader>gs"] = map(function() require("telescope.builtin").git_status() end):silent():desc("Search Git status")
  mappings.n["<leader>gf"] = map(function() require("telescope.builtin").git_files() end):silent():desc("Search Git files")
end

if is_available("gitsigns.nvim") then
  mappings.n["[h"] = map(function() require("gitsigns").prev_hunk() end):silent():desc("Prev git hunk")
  mappings.n["]h"] = map(function() require("gitsigns").next_hunk() end):silent():desc("Next git hunk")
  mappings.n["<leader>ga"] = map(function() require("gitsigns").stage_hunk() end):silent():desc("Git stage hunk")
  mappings.n["<leader>gA"] = map(function() require("gitsigns").stage_buffer() end):silent():desc("Git stage buffer")
  mappings.n["<leader>gu"] = map(function() require("gitsigns").undo_stage_hunk() end):silent():desc("Git unstage hunk")
  mappings.n["<leader>gd"] = map(function() require("gitsigns").diffthis() end):silent():desc("Git difference")
  mappings.n["<leader>gD"] = map(function() require("gitsigns").diffthis('~') end):silent():desc("Git difference all")
  mappings.n["<leader>gr"] = map(function() require("gitsigns").reset_hunk() end):silent():desc("Git reset hunk")
  mappings.n["<leader>gR"] = map(function() require("gitsigns").reset_buffer() end):silent():desc("Git unstage buffer")
  mappings.n["<leader>gt"] = map(function() require("gitsigns").toggle_current_line_blame() end):silent():desc("Toggle line blame")
  mappings.n["<leader>gT"] = map(function() require("gitsigns").blame_line({full=true}) end):silent():desc("Toggle full blame")
  mappings.n["<leader>gx"] = map(function() require("gitsigns").toggle_deleted() end):silent():desc("Toggle deleted")
  -- Text object
  mappings.o["ih"] = map(":<C-U>Gitsigns select_hunk<CR>"):desc("Select in hunk")
  mappings.x["ih"] = map(":<C-U>Gitsigns select_hunk<CR>"):desc("Select in hunk")
end

-- TODO: more key maps with vim-fugitive
if is_available("vim-fugitive") then
  mappings.n["<leader>g<CR>"] = map("<CMD>Git<CR>"):silent():desc("Git fugitive status")
  mappings.n["<leader>gp"] = map("<CMD>Git pull<CR>"):silent():desc("Git pull")
  mappings.n["<leader>gP"] = map("<CMD>Git push<CR>"):silent():desc("Git push")
end

return mappings
