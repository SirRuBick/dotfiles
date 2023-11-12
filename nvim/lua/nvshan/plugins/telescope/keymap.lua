local is_available = require("utils").is_available
local keymap_utils = require("nvshan.keymap.utils")
local mappings = keymap_utils.init_mapping()
local map = keymap_utils.map


if not is_available("telescope.nvim") then
  vim.notify("Failed to load telescope", vim.log.levels.ERROR)
  return {}
end


mappings.n["<leader>fg"] = map():desc("Find git related")
mappings.n["<leader>fgb"] = map(function() require("telescope.builtin").git_branches() end):silent():desc("Search git branches")
mappings.n["<leader>fgc"] = map(function() require("telescope.builtin").git_commits() end):silent():desc("Search Git commits")
mappings.n["<leader>fgs"] = map(function() require("telescope.builtin").git_status() end):silent():desc("Search Git status")
mappings.n["<leader>fR"] = map(function() require("telescope.builtin").resume() end):silent():desc("Resume previous search")
mappings.n["<leader>f'"] = map(function() require("telescope.builtin").marks() end):silent():desc("Find marks")
mappings.n["<leader>fb"] = map(function() require("telescope.builtin").buffers() end):silent():desc("Find buffers")
mappings.n["<leader>fc"] = map(function() require("telescope.builtin").grep_string() end):silent():desc("Find for word under cursor")
mappings.n["<leader>fC"] = map(function() require("telescope.builtin").commands() end):silent():desc("Find commands")
mappings.n["<leader>ff"] = map(function() require("telescope.builtin").find_files() end):silent():desc("Find files")
mappings.n["<leader>fh"] = map(function() require("telescope.builtin").help_tags() end):silent():desc("Find help")
mappings.n["<leader>fk"] = map(function() require("telescope.builtin").keymappings() end):silent():desc("Find keymappings")
mappings.n["<leader>fm"] = map(function() require("telescope.builtin").man_pages() end):silent():desc("Find man")
mappings.n["<leader>fo"] = map(function() require("telescope.builtin").oldfiles() end):silent():desc("Find history")
mappings.n["<leader>fr"] = map(function() require("telescope.builtin").registers() end):silent():desc("Find registers")
mappings.n["<leader>fe"] = map(function() require("telescope.builtin").treesitter() end):silent():desc("Find treesitter")
mappings.n["<leader>fT"] = map(function() require("telescope.builtin").colorscheme() end):silent():desc("Find themes")
mappings.n["<leader>fw"] = map(function() require("telescope.builtin").live_grep() end):silent():desc("Find words")
mappings.n["<leader>fW"] = map(
  function()
    require("telescope.builtin").live_grep(
      {
        additional_args = function(args)
          return vim.list_extend(args, { "--hidden", "--no-ignore" })
        end,
      }
    )
  end
):desc("Find words in all files")
mappings.n["<leader>lD"] = map(function() require("telescope.builtin").diagnostics() end):silent():desc("Search diagnostics")


return mappings
