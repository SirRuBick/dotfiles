-- Autocommands
local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- Fire CookLazy on VimEnter for early-loaded plugins
vim.api.nvim_create_autocmd("VimEnter", {
  group = augroup,
  callback = function()
    vim.schedule(function()
      vim.api.nvim_exec_autocmds("User", { pattern = "CookLazy" })
    end)
  end,
})

-- Fire LazyFile on first buffer read for file-dependent plugins
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  group = augroup,
  desc = "LazyFile event",
  pattern = "*",
  once = true,
  callback = function()
    if not vim.g._lazyfile_triggered then
      vim.g._lazyfile_triggered = true
      vim.schedule(function()
        vim.api.nvim_exec_autocmds("User", { pattern = "LazyFile" })
      end)
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  desc = "Highlight yanked text",
  callback = function()
    vim.highlight.on_yank({ timeout = 500 })
  end,
})

-- Disable auto-wrap comments
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  desc = "Disable auto-wrap comments",
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r" })
  end,
})

-- Auto-save on buffer leave or focus lost
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
  group = augroup,
  pattern = "*",
  callback = function()
    if vim.bo.buftype == "" and vim.bo.modified and vim.fn.expand("%") ~= "" then
      local ok, err = pcall(vim.cmd, "write")
      if not ok then
        vim.notify("Auto-save error: " .. err, vim.log.levels.ERROR)
      end
    end
  end,
})
