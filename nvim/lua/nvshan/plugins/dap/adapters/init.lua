-- NOTE: the dap set up is a bit messy
local M = {}

local scandir = require("utils").scandir

local info = debug.getinfo(1, "S")
local module_directory = string.match(info.source, "^@(.*)/")
local module_filename = string.match(info.source, "/([^/]*)$")
local module_name = ...

function M.setup(dap)
  require("dap.ext.vscode").load_launchjs(nil, { cppdbg = { "c", "cpp", "rust" }, codelldb = { "c", "cpp", "rust" }, debugpy = { "python" } })

  local config_files = vim.tbl_filter(function(filename)
    local is_lua_module = string.match(filename, "[.]lua$")
    local is_this_file = filename == module_filename
    return is_lua_module and not is_this_file
  end, scandir(module_directory))

  for i, filename in ipairs(config_files) do
    local config_module = string.match(filename, "(.+).lua$")
    require(module_name .. "." .. config_module).setup(dap)
  end

  dap.configurations.c = dap.configurations.cpp
  dap.configurations.rust = dap.configurations.cpp
end

return M
