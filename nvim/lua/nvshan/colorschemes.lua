local C = {}
local default = require("settings").colorscheme

-- get all available colorschemes
function C.get_available_colorschemes()
  local available_colorschemes = {}
  local colorthemes = require("nvshan.plugins.colorschemes")
  for _, colortheme in ipairs(colorthemes) do
    local cname = colortheme.name
    local status_ok, lazy = pcall(require, "lazy.core.config")
    if status_ok and lazy.plugins[cname] ~= nil then
      table.insert(available_colorschemes, cname)
    else
      vim.notify("Colortheme: " .. cname .. " not found in lazy.nvim", vim.log.levels.WARN)
    end
  end
  return available_colorschemes
end

function C.random_colorscheme(available_colorschemes)
  math.randomseed(os.time())
  return available_colorschemes[math.random(#available_colorschemes)]
end

function C.set_colorscheme()
  local available_colorschemes = C.get_available_colorschemes()
  local colorscheme = available_colorschemes[1]
  if default == "random" then
    colorscheme = C.random_colorscheme(available_colorschemes)
  elseif vim.tbl_contains(available_colorschemes, default) then
    colorscheme = default
  else
    colorscheme = available_colorschemes[1]
    vim.notify("Unable to set colorscheme as " .. default .. ", use " .. colorscheme, vim.log.levels.WARN)
  end
  -- set color scheme
  if not pcall(vim.cmd.colorscheme, colorscheme) then
    vim.notify("Error setting up colorscheme: " .. colorscheme, vim.log.levels.ERROR)
  else
    if colorscheme ~= default then
      vim.notify("Colorscheme: " .. colorscheme .. " loaded", vim.log.levels.INFO)
    end
  end
end

C.set_colorscheme()

return C
