-- render-markdown.nvim: inline markdown rendering
local ok, render_markdown = pcall(require, "render-markdown")
if not ok then return end

render_markdown.setup({
  file_types = { "markdown" },
  render_modes = { "n", "c" },
  heading = {
    enabled = true,
    sign = true,
    position = "inline",
    icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
  },
  code = {
    enabled = true,
    sign = true,
    style = "full",
    position = "left",
    language_pad = 0,
    disable_background = { "diff" },
  },
  dash = {
    enabled = true,
    icon = "─",
    width = "full",
  },
  bullet = {
    enabled = true,
    icons = { "●", "○", "◆", "◇" },
  },
  checkbox = {
    enabled = true,
    unchecked = { icon = "󰄱 " },
    checked = { icon = "󰱒 " },
  },
  quote = {
    enabled = true,
    icon = "┃",
  },
  pipe_table = {
    enabled = true,
    style = "full",
  },
  link = {
    enabled = true,
    icon = "",
  },
  sign = {
    enabled = true,
  },
})
