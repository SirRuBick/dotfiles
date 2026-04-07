-- ### Autocommands
--
-- Autocmds that helps to make neovim behave better.
--
-- @Author: alex.shan
-- @Date:  2023
--

local is_available = require("utils").is_available
local settings = require("settings")

-- Auto close NvimTree
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

-- Auto resize split
vim.api.nvim_create_autocmd("VimResized", {
  group = vim.api.nvim_create_augroup("ResizeSplit", { clear = true }),
  pattern = "*",
  callback = function()
    vim.api.nvim_command([[wincmd =]])
  end,
})

-- -- Distinguish active and inactive window
-- vim.api.nvim_create_autocmd("WinEnter", {
-- 	group = vim.api.nvim_create_augroup("SetCulInActiveWindow", { clear = true }),
-- 	pattern = "*",
-- 	callback = function()
-- 		vim.api.nvim_command([[setlocal cursorline]])
-- 		-- vim.api.nvim_command([[setlocal number]])
-- 		-- vim.api.nvim_command([[setlocal relativenumber]])
-- 		-- vim.api.nvim_command([[highlight! Normal guibg=#1e222a]])
-- 	end,
-- })
-- vim.api.nvim_create_autocmd("WinLeave", {
-- 	group = vim.api.nvim_create_augroup("UnsetCulInActiveWindow", { clear = true }),
-- 	pattern = "*",
-- 	callback = function()
-- 		vim.api.nvim_command([[setlocal nocursorline]])
-- 		-- vim.api.nvim_command([[setlocal nonumber]])
-- 		-- vim.api.nvim_command([[setlocal norelativenumber]])
-- 		-- vim.api.nvim_command([[highlight! Normal guibg=#1e222a]])
-- 	end,
-- })

-- Auto Lint
if is_available("nvim-lint") and settings.auto_lint then
  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    group = vim.api.nvim_create_augroup("AutoLint", { clear = true }),
    pattern = "*",
    callback = function()
      local status_ok, lint = pcall(require, "lint")
      if status_ok then
        lint.try_lint()
      else
        vim.notify("Lint is not available", vim.log.levels.WARN, { title = "AutoLint" })
      end
    end,
  })
end
