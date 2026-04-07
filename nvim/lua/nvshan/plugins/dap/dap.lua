local dap = require("dap")

-- Change DAP signs
local icons = require("icons")
vim.fn.sign_define("DapBreakpoint", { text = icons.dap.Breakpoint, texthl = "DapBreakpoint", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = icons.dap.BreakpointCondition, texthl = "DapBreakpoint", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = icons.dap.Stopped, texthl = "DapStopped", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = icons.dap.BreakpointRejected, texthl = "DapBreakpoint", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = icons.dap.LogPoint, texthl = "DapLogPoint", linehl = "", numhl = "" })

-- Auto open and close dapui
local status_ok, dapui = pcall(require, "dapui")
if status_ok then
  dap.listeners.before.attach.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
  end
  dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
  end
else
  vim.notify("DAP UI is missing", vim.log.levels.WARN)
end

-- Config DAP adapters
local adapters = require("nvshan.plugins.dap.adapters")
adapters.setup(dap)

-- Auto install debuggers with mason
local status_ok, mason_dap = pcall(require, "mason-nvim-dap")
if status_ok then
  mason_dap.setup({
    ensure_installed = {},
    automatic_installation = true,
    handlers = nil,
  })
else
  vim.notify("Failed to load mason-nvim-dap, debuggers may not be auto installed", vim.log.levels.WARN)
end
