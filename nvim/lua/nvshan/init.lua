for _, source in ipairs({
  "nvshan.options",
  "nvshan.lazy",
  "nvshan.keymap",
  "nvshan.autocmds",
  "nvshan.colorschemes",
}) do
  local status_ok, mod = pcall(require, source)
  if not status_ok then
    vim.api.nvim_err_writeln("Failed to load " .. source .. "\n" .. mod)
  end
end
