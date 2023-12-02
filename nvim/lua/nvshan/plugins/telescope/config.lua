local is_available = require("utils").is_available
local telescope = require "telescope"

telescope.load_extension("media_files")
telescope.load_extension("fzy_native")
if is_available("nvim-notify") then
  telescope.load_extension("notify")
end
if is_available("project.nvim") then
  telescope.load_extension("projects")
end

local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    git_worktrees = vim.g.git_worktrees,
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "truncate" },
    sorting_strategy = "ascending",
    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
      n = { q = actions.close },
    },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
    media_files = {
      -- filetypes whitelist
      -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      filetypes = { "png", "webp", "jpg", "jpeg" },
      find_cmd = "rg", -- find command (defaults to `fd`)
    },
    fzy_native = {
      override_generic_sorter = true,
      override_file_sorter = true,
    },
  },
})
