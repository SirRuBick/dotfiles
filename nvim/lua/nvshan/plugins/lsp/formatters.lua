local is_available = require("utils").is_available

if not is_available("conform.nvim") then
  return {}
end

local formatters = {}

formatters.black = {
  args = {
    "--stdin-filename",
    "$FILENAME",
    "--quiet",
    "--line-length=120",
    "-",
  },
}

return formatters
