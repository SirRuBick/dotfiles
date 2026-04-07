local settings = require("settings")

local function db_completion()
  require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
end

vim.g.db_ui_save_location = settings.db_ui_save_location

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "sql",
  },
  command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "sql",
    "mysql",
    "plsql",
  },
  callback = function()
    vim.schedule(db_completion)
  end,
})
