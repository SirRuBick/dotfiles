local status_ok, lualine = pcall(require, "lualine")

if not status_ok then
  vim.notify("Failed to load lualine", vim.log.levels.ERROR)
  return
end

-- show lint progress
local lint_progress = function()
  local linters = require("lint").get_running()
  if #linters == 0 then
    return "󰦕"
  end
  return "󱉶 " .. table.concat(linters, ", ")
end

-- Codium
local codeium_status = function()
  return "" .. vim.api.nvim_call_function("codeium#GetStatusString", {})
end

lualine.setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    -- component_separators = { left = "", right = "" },
    -- section_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },

  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { "fileformat", "filetype", "hostname" },
    lualine_z = { "location", "progress" },
  },
  inactive_sections = {
    lualine_a = { "mode" },
    lualine_b = { "filename" },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
})
