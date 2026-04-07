local M = {}
local global = require("global")
local input_file_path = require("nvshan.plugins.dap.utils").input_file_path
local get_input_args = require("nvshan.plugins.dap.utils").get_input_args

local function find_python_venv()
  local cwd, venv = vim.fn.getcwd(), os.getenv("VIRTUAL_ENV")
  if venv and vim.fn.executable(venv .. "/bin/python") == 1 then
    return venv .. "/bin/python"
  elseif vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
    return cwd .. "/venv/bin/python"
  elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
    return cwd .. "/.venv/bin/python"
  else
    return "/usr/bin/python"
  end
end

---@param venv string
---@return string
local function python_exe(venv)
  if global.is_windows then return venv .. "\\Scripts\\python3.exe" end
  return venv .. "/bin/python3"
end

local function roots()
  return coroutine.wrap(function()
    local cwd = vim.fn.getcwd()
    coroutine.yield(cwd)

    local wincwd = vim.fn.getcwd(0)
    if wincwd ~= cwd then coroutine.yield(wincwd) end

    ---@diagnostic disable-next-line: deprecated
    local get_clients = vim.lsp.get_clients or vim.lsp.get_active_clients
    for _, client in ipairs(get_clients()) do
      if client.config.root_dir then coroutine.yield(client.config.root_dir) end
    end
  end)
end

local get_python_path = function()
  local venv_path = os.getenv("VIRTUAL_ENV")
  if venv_path then return python_exe(venv_path) end

  venv_path = os.getenv("CONDA_PREFIX")
  if venv_path then
    if global.is_windows then return venv_path .. "\\python.exe" end
    return venv_path .. "/bin/python"
  end

  if M.resolve_python then
    assert(type(M.resolve_python) == "function", "resolve_python must be a function")
    return M.resolve_python()
  end

  for root in roots() do
    for _, folder in ipairs({ "venv", ".venv", "env", ".env" }) do
      local path = root .. "/" .. folder
      local stat = vim.loop.fs_stat(path)
      if stat and stat.type == "directory" then return python_exe(path) end
    end
  end

  return nil
end

function M.setup(dap)
  dap.adapters.python = function(cb, config)
    if config.request == "attach" then
      ---@diagnostic disable-next-line: undefined-field
      local port = (config.connect or config).port
      ---@diagnostic disable-next-line: undefined-field
      local host = (config.connect or config).host or "127.0.0.1"
      cb({
        type = "server",
        port = assert(port, "`connect.port` is required for a python `attach` configuration"),
        host = host,
        options = {
          source_filetype = "python",
        },
      })
    else
      cb({
        type = "executable",
        command = vim.fn.exepath("debugpy-adapter"),
        options = {
          source_filetype = "python",
        },
      })
    end
  end

  dap.configurations.python = dap.configurations.python or {}
  table.insert(dap.configurations.python, {
    -- The first three options are required by nvim-dap
    type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = "launch",
    name = "debugpy: Launch file",
    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
    program = "${file}", -- This configuration will launch the current file if used.
    console = "integratedTerminal",
    pythonPath = get_python_path,
  })
  table.insert(dap.configurations.python, {
    type = "python",
    requst = "launch",
    name = "debugpy: Launch input file",
    -- BUG: it seems nvim-dap doesn't support launch with absolute file path
    program = input_file_path,
    console = "integratedTerminal",
    pythonPath = get_python_path,
  })
  table.insert(dap.configurations.python, {
    type = "python",
    requst = "launch",
    name = "debugpy: Launch file with arguments",
    program = "${file}",
    args = get_input_args,
    console = "integratedTerminal",
    pythonPath = get_python_path,
  })
  table.insert(dap.configurations.python, {
    type = "python",
    requst = "launch",
    name = "debugpy: Launch module with arguments",
    module = function()
      return vim.fn.input("Module: ")
    end,
    args = get_input_args,
    console = "integratedTerminal",
    pythonPath = get_python_path,
  })
  table.insert(dap.configurations.python, {
    type = "python",
    requst = "attach",
    name = "debugpy: Attach remote",
    connect = function()
      local host = vim.fn.input("Host [127.0.0.1]: ")
      host = host ~= "" and host or "127.0.0.1"
      local port = tonumber(vim.fn.input("Port [5678]: ")) or 5678
      return { host = host, port = port }
    end,
  })
  table.insert(dap.configurations.python, {
    type = "python",
    requst = "launch",
    name = "debugpy: Run doctests in file",
    module = "doctest",
    program = "${file}",
    args = { "${file}" },
    noDebug = true,
    console = "integratedTerminal",
    pythonPath = get_python_path,
  })
end

return M
