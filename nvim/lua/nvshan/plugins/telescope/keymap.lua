local is_available = require("utils").is_available
local keymap_utils = require("nvshan.keymap.utils")
local mappings = keymap_utils.init_mapping()
local map = keymap_utils.map


if not is_available("telescope.nvim") then
  vim.notify("Failed to load telescope", vim.log.levels.ERROR)
  return {}
end


mappings.n["<leader>fg"] = map():desc("Find git related")
mappings.n["<leader>fgb"] = map(require('telescope.builtin').git_branches):silent():desc("Search git branches")
mappings.n["<leader>fgc"] = map(require('telescope.builtin').git_commits):silent():desc("Search Git commits")
mappings.n["<leader>fgs"] = map(require('telescope.builtin').git_status):silent():desc("Search Git status")
mappings.n["<leader>fR"] = map(require('telescope.builtin').resume):silent():desc("Resume previous search")
mappings.n["<leader>f'"] = map(require('telescope.builtin').marks):silent():desc("Find marks")
mappings.n["<leader>fb"] = map(require('telescope.builtin').buffers):silent():desc("Find buffers")
mappings.n["<leader>fc"] = map(require('telescope.builtin').grep_string):silent():desc("Find for word under cursor")
mappings.n["<leader>fC"] = map(require('telescope.builtin').commands):silent():desc("Find commands")
mappings.n["<leader>ff"] = map(require('telescope.builtin').find_files):silent():desc("Find files")
mappings.n["<leader>fh"] = map(require('telescope.builtin').help_tags):silent():desc("Find help")
mappings.n["<leader>fk"] = map(require('telescope.builtin').keymappings):silent():desc("Find keymappings")
mappings.n["<leader>fm"] = map(require('telescope.builtin').man_pages):silent():desc("Find man")
mappings.n["<leader>fo"] = map(require('telescope.builtin').oldfiles):silent():desc("Find history")
mappings.n["<leader>fr"] = map(require('telescope.builtin').registers):silent():desc("Find registers")
mappings.n["<leader>ft"] = map(require('telescope.builtin').treesitter):silent():desc("Find treesitter")
mappings.n["<leader>fT"] = map(require('telescope.builtin').colorscheme):silent():desc("Find themes")
mappings.n["<leader>fw"] = map(require('telescope.builtin').live_grep):silent():desc("Find words")
mappings.n["<leader>fW"] = map(
  function()
    require('telescope.builtin').live_grep(
      {
        additional_args = function(args)
          return vim.list_extend(args, { "--hidden", "--no-ignore" })
        end,
      }
    )
  end
):desc("Find words in all files")
mappings.n["<leader>lD"] = map(require('telescope.builtin').diagnostics):silent():desc("Search diagnostics")

print('telescope mapping loaded')
return mappings
