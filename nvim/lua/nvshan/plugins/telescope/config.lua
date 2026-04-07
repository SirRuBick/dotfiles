local is_available = require("utils").is_available
local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.load_extension("media_files")

telescope.load_extension("fzy_native")

if is_available("nvim-notify") then
  telescope.load_extension("notify")
end

if is_available("project.nvim") then
  telescope.load_extension("projects")
end

if is_available("telescope-undo.nvim") then
  telescope.load_extension("undo")
end

if is_available("persisted.nvim") then
  telescope.load_extension("persisted")
end

local mappings = {
  i = {
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
  n = {
    ["q"] = actions.close,
  },
}

if is_available("trouble.nvim") then
  local trouble = require("trouble.sources.telescope")
  mappings = vim.tbl_deep_extend("force", mappings, {
    i = { ["<c-t>"] = trouble.open },
    n = { ["<c-t>"] = trouble.open },
  })
end

if is_available("flash.nvim") then
  local function flash(prompt_bufnr)
    require("flash").jump({
      pattern = "^",
      label = { after = { 0, 0 } },
      search = {
        mode = "search",
        exclude = {
          function(win)
            return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
          end,
        },
      },
      action = function(match)
        local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
        picker:set_selection(match.pos[1] - 1)
      end,
    })
  end
  mappings = vim.tbl_deep_extend("force", mappings, {
    n = { s = flash },
    i = { ["<c-s>"] = flash },
  })
end

telescope.setup({
  defaults = {
    git_worktrees = vim.g.git_worktrees,
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "truncate" },
    sorting_strategy = "ascending",
    mappings = mappings,
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
    undo = {
      side_by_side = true,
      layout_strategy = "vertical",
    },
    persisted = {
      layout_config = { width = 0.6, height = 0.6 },
    },
  },
})
