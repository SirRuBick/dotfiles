local settings = require("settings")

for _, source in ipairs {
  "nvshan.options",
  "nvshan.lazy",
  "nvshan.keymap",
  "nvshan.autocmds",
} do
  local status_ok, mod = pcall(require, source)
  if not status_ok then vim.api.nvim_err_writeln("Failed to load " .. source .. "\n" .. mod) end
end

if settings.colorscheme then
  if not pcall(vim.cmd.colorscheme, settings.colorscheme) then
    vim.notify("Error setting up colorscheme: " .. settings.colorscheme, vim.log.levels.ERROR)
  end
end
