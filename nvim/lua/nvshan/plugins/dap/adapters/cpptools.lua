local M = {}
local utils = require("utils")

function M.setup()
  local dap = require("dap")
  dap.adapters.cppdbg = {
    id = "cppdbg",
    type = "executable",
    -- command = "/absolute/path/to/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
    command = vim.fn.exepath("OpenDebugAD7"),
  }

  dap.configurations.cpp = dap.configurations.cpp or {}
  table.insert(dap.configurations.cpp, {
    name = "cpptools: Launch file",
    type = "cppdbg",
    request = "launch",
    program = utils.telescope_find_file,
    cwd = "${workspaceFolder}",
    stopAtEntry = true,
  })
  table.insert(dap.configurations.cpp, {
    name = "cpptools: Attach to gdbserver :1234",
    type = "cppdbg",
    request = "launch",
    MIMode = "gdb",
    miDebuggerServerAddress = "localhost:1234",
    -- miDebuggerPath = "/usr/bin/gdb",
    miDebuggerPath = vim.fn.exepath("gdb"),
    cwd = "${workspaceFolder}",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
  })
  table.insert(dap.configurations.cpp, {
    name = "cpptools: Attach process",
    type = "cppdbg",
    request = "attach",
    processId = require("dap.utils").pick_process,
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    setupCommands = {
      {
        description = "enable pretty printing",
        text = "-enable-pretty-printing",
        ignoreFailures = false,
      },
    },
  })
end

return M
