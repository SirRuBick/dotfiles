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

-- Tabwidth: default 4, exceptions at 2
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  desc = "Set tabwidth for json/markdown/html to 2",
  pattern = { "json", "jsonc", "markdown", "html", "css", "yaml" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
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

-- Lazy-load render-markdown on first markdown file
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "markdown",
  once = true,
  callback = function()
    vim.cmd("packadd render-markdown.nvim")
    local ok, rm = pcall(require, "render-markdown")
    if not ok then return end
    rm.setup({
      file_types = { "markdown" },
      render_modes = { "n", "c" },
      heading = {
        enabled = true, sign = true, position = "inline",
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      },
      code = { enabled = true, sign = true, style = "full", position = "left", language_pad = 0, disable_background = { "diff" } },
      dash = { enabled = true, icon = "─", width = "full" },
      bullet = { enabled = true, icons = { "●", "○", "◆", "◇" } },
      checkbox = { enabled = true, unchecked = { icon = "󰄱 " }, checked = { icon = "󰱒 " } },
      quote = { enabled = true, icon = "┃" },
      pipe_table = { enabled = true, style = "full" },
      link = { enabled = true, icon = "" },
      sign = { enabled = true },
    })
    vim.keymap.set("n", "<leader>tm", "<cmd>RenderMarkdown toggle<cr>", { desc = "Toggle markdown rendering" })
  end,
})

-- Equalize splits on terminal/monitor resize
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup,
  desc = "Equalize splits on resize",
  pattern = "*",
  callback = function()
    vim.cmd("wincmd =")
  end,
})

-- Cursorline only in active window
vim.api.nvim_create_autocmd("WinEnter", {
  group = augroup,
  desc = "Enable cursorline on active window",
  pattern = "*",
  callback = function()
    vim.opt_local.cursorline = true
  end,
})
vim.api.nvim_create_autocmd("WinLeave", {
  group = augroup,
  desc = "Disable cursorline on inactive window",
  pattern = "*",
  callback = function()
    vim.opt_local.cursorline = false
  end,
})
