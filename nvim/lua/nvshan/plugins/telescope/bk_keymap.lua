local is_available = require("utils").is_available
local maps = require("nvshan.keymap.utils").init_mapping()

-- Telescope
if is_available("telescope.nvim") then
  maps.n["<leader>gb"] = { require('telescope.builtin').git_branches, desc = "Git branches" }
  maps.n["<leader>gc"] = { require('telescope.builtin').git_commits, desc = "Git commits" }
  maps.n["<leader>gt"] = { require('telescope.builtin').git_status, desc = "Git status" }
  maps.n["<leader>f<CR>"] = { require('telescope.builtin').resume, desc = "Resume previous search" }
  maps.n["<leader>f'"] = { require('telescope.builtin').marks, desc = "Find marks" }

  maps.n["<leader>fb"] = { require('telescope.builtin').buffers, desc = "Find buffers" }
  maps.n["<leader>fc"] = { require('telescope.builtin').grep_string, desc = "Find for word under cursor" }
  maps.n["<leader>fC"] = { require('telescope.builtin').commands, desc = "Find commands" }
  maps.n["<leader>ff"] = { require('telescope.builtin').find_files, desc = "Find files" }
  maps.n["<leader>fh"] = { require('telescope.builtin').help_tags, desc = "Find help" }
  maps.n["<leader>fk"] = { require('telescope.builtin').keymaps, desc = "Find keymaps" }
  maps.n["<leader>fm"] = { require('telescope.builtin').man_pages, desc = "Find man" }
  if is_available("nvim-notify") then
    maps.n["<leader>fn"] = {
      function()
        require("telescope").extensions.notify.notify()
      end,
      desc = "Find notifications",
    }
  end
  maps.n["<leader>fo"] = { require('telescope.builtin').oldfiles, desc = "Find history" }
  maps.n["<leader>fr"] = { require('telescope.builtin').registers, desc = "Find registers" }
  maps.n["<leader>ft"] = { require('telescope.builtin').colorscheme, desc = "Find themes" }
  maps.n["<leader>fw"] = { require('telescope.builtin').live_grep, desc = "Find words" }
  maps.n["<leader>fW"] = {
    function()
      require('telescope.builtin').live_grep({
        additional_args = function(args)
          return vim.list_extend(args, { "--hidden", "--no-ignore" })
        end,
      })
    end,
    desc = "Find words in all files",
  }
  maps.n["<leader>lD"] = { require('telescope.builtin').diagnostics, desc = "Search diagnostics" }
end

return maps
