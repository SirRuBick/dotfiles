-- ### Autocommands
--
-- Autocmds that helps to make neovim behave better.
--
-- @Author: alex.shan
-- @Date:  2023
--

local is_available = require("utils").is_available
local enable_transparent = require("settings").transparent


-- auto close NvimTree
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
  pattern = "NvimTree_*",
  callback = function()
    local layout = vim.api.nvim_call_function("winlayout", {})
    if
        layout[1] == "leaf"
        and vim.api.nvim_get_option_value("filetype", { buf = vim.api.nvim_win_get_buf(layout[2]) }) == "NvimTree"
        and layout[3] == nil
    then
      vim.api.nvim_command([[confirm quit]])
    end
  end,
})
