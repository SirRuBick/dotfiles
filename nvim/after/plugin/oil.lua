-- Oil file explorer
local ok, oil = pcall(require, "oil")
if not ok then return end

oil.setup()

vim.keymap.set("n", "<leader>e", function()
  if vim.bo.filetype == "oil" then
    oil.close()
  else
    oil.open()
  end
end, { desc = "Toggle Oil" })
