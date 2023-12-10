local is_available = require("utils").is_available
local keymap_utils = require("nvshan.keymap.utils")
local mappings = keymap_utils.init_mapping()
local map = keymap_utils.map

if not is_available("telescope.nvim") then
  vim.notify("Failed to load telescope", vim.log.levels.ERROR)
  return {}
end

mappings.n["<leader>f'"] = map(function() require("telescope.builtin").grep_string() end):silent():desc("Find for word under cursor")
mappings.n["<leader>fa"] = map(function() require("telescope.builtin").autocommands() end):silent():desc("Find autocommands")
mappings.n["<leader>fb"] = map(function() require("telescope.builtin").buffers() end):silent():desc("Find buffers")
mappings.n["<leader>fc"] = map(function() require("telescope.builtin").current_buffer_fuzzy_find() end):silent():desc("Find in current buffer")
mappings.n["<leader>fC"] = map(function() require("telescope.builtin").commands() end):silent():desc("Find commands")
mappings.n["<leader>fe"] = map(function() require("telescope.builtin").treesitter() end):silent():desc("Find treesitter")
mappings.n["<leader>ff"] = map(function() require("telescope.builtin").find_files() end):silent():desc("Find files")
mappings.n["<leader>fh"] = map(function() require("telescope.builtin").help_tags() end):silent():desc("Find help")
mappings.n["<leader>fk"] = map(function() require("telescope.builtin").keymaps() end):silent():desc("Find keymaps")
mappings.n["<leader>fm"] = map(function() require("telescope.builtin").marks() end):silent():desc("Find marks")
mappings.n["<leader>fM"] = map(function() require("telescope.builtin").man_pages() end):silent():desc("Find man")
if is_available("nvim-notify") then
  mappings.n["<leader>fn"] = map(function() require("telescope").extensions.notify.notify() end):silent():desc("Find notification history")
end
mappings.n["<leader>fo"] = map(function() require("telescope.builtin").oldfiles() end):silent():desc("Find history")
if is_available("project.nvim") then
  mappings.n["<leader>fp"] = map(function() require("telescope").extensions.projects.projects() end):silent():desc("Find projects")
end
mappings.n["<leader>fr"] = map(function() require("telescope.builtin").registers() end):silent():desc("Find registers")
mappings.n["<leader>fR"] = map(function() require("telescope.builtin").resume() end):silent():desc("Resume previous search")
mappings.n["<leader>fs"] = map(function() require("telescope.builtin").spell_suggest() end):silent():desc("Find spell suggests")
mappings.n["<leader>ft"] = map(function() require("telescope.builtin").tags() end):silent():desc("Find tags")
mappings.n["<leader>fT"] = map(function() require("telescope.builtin").colorscheme() end):silent():desc("Find themes")
mappings.n["<leader>fv"] = map(function() require("telescope").extensions.media_files.media_files() end):silent():desc("Find media files")
mappings.n["<leader>fV"] = map(function() require("telescope.builtin").vim_options() end):silent():desc("Find vim options")
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

return mappings
