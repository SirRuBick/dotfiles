-- ### Autocommands
--
-- Autocmds that helps to make neovim behave better.
--
-- @Author: alex.shan
-- @Date:  2023
--


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


-- TODO: add auto command to resource config if settings.lua is changed
-- auto command to resource config if settings.lua is changed
-- vim_path = require("global").vim_path
-- vim.api.nvim_create_autocmd("BufWritePost", {
--   group = vim.api.nvim_create_augroup("ReloadConfig", { clear = true }),
--   pattern = "lua/configs/settings.lua",
--   callback = function()
--     vim.api.nvim_command(":luafile %")
--   end,
-- })
