local M = {}
local utils = require("utils")

function M.setup()
  local dap = require("dap")

  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      command = vim.fn.exepath("codelldb"),
      args = { "--port", "${port}" },

      -- On windows you may have to uncomment this:
      -- detached = false,
    },
  }

  dap.configurations.cpp = dap.configurations.cpp or {}
  table.insert(dap.configurations.cpp, {
    name = "codelldb: Launch file",
    type = "codelldb",
    request = "launch",
    program = utils.telescope_find_file,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  })
  table.insert(dap.configurations.cpp, {
    -- If you get an "Operation not permitted" error using this, try disabling YAMA:
    --  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    name = "codelldb: Attach to process",
    type = "codelldb",
    request = "attach",
    pid = require("dap.utils").pick_process,
    args = {},
  })
end

return M
