local api = vim.api

local exclude_ft = { "help", "git", "markdown", "snippets", "text", "gitconfig", "alpha", "dashboard" }

-- Multiple indent colors
-- local highlight = {
--     "RainbowRed",
--     "RainbowYellow",
--     "RainbowBlue",
--     "RainbowOrange",
--     "RainbowGreen",
--     "RainbowViolet",
--     "RainbowCyan",
-- }
--
-- local hooks = require "ibl.hooks"
-- -- create the highlight groups in the highlight setup hook, so they are reset
-- -- every time the colorscheme changes
-- hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
--     api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
--     api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
--     api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
--     api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
--     api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
--     api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
--     api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
-- end)
--
--
-- require("ibl").setup {
--   indent = {
--     char = "▏",
--     highlight = highlight,
--   },
--   scope = {
--     show_start = false,
--     show_end = false,
--   },
--   exclude = {
--     filetypes = exclude_ft,
--     buftypes = { "terminal" },
--   },
-- }

-- Background color indentation guides
local highlight = {
      "CursorColumn",
      "Whitespace",
}
require("ibl").setup {
      indent = { highlight = highlight, char = "" },
      whitespace = {
          highlight = highlight,
          remove_blankline_trail = false,
      },
      scope = { enabled = false },
}


local gid = api.nvim_create_augroup("indent_blankline", { clear = true })
api.nvim_create_autocmd("InsertEnter", {
  pattern = "*",
  group = gid,
  command = "IBLDisable",
})

api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  group = gid,
  callback = function()
    if not vim.tbl_contains(exclude_ft, vim.bo.filetype) then
      vim.cmd([[IBLEnable]])
    end
  end,
})
