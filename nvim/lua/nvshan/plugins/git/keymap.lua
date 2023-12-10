local is_available = require("utils").is_available
local keymap_utils = require("nvshan.keymap.utils")
local mappings = keymap_utils.init_mapping()
local map = keymap_utils.map


if is_available("telescope.nvim") then
  mappings["<leader>gb"] = map(function() require("telescope.builtin").git_branches() end):silent():desc("Search git branches")
  mappings["<leader>gc"] = map(function() require("telescope.builtin").git_commits() end):silent():desc("Search Git commits")
  mappings["<leader>gs"] = map(function() require("telescope.builtin").git_status() end):silent():desc("Search Git status")
  mappings["<leader>gf"] = map(function() require("telescope.builtin").git_files() end):silent():desc("Search Git files")
end

