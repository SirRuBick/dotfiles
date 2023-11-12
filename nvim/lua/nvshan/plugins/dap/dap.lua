local icons = require("icons")
local dap, dapui = require "dap", require "dapui"
dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open({ reset = true }) end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

-- Change DAP signs
vim.fn.sign_define(
  "DapBreakpoint",
  { text = icons.dap.Breakpoint, texthl = "DapBreakpoint", linehl = "", numhl = "" }
)
vim.fn.sign_define(
  "DapBreakpointCondition",
  { text = icons.dap.BreakpointCondition, texthl = "DapBreakpoint", linehl = "", numhl = "" }
)
vim.fn.sign_define("DapStopped", { text = icons.dap.Stopped, texthl = "DapStopped", linehl = "", numhl = "" })
vim.fn.sign_define(
  "DapBreakpointRejected",
  { text = icons.dap.BreakpointRejected, texthl = "DapBreakpoint", linehl = "", numhl = "" }
)
vim.fn.sign_define("DapLogPoint", { text = icons.dap.LogPoint, texthl = "DapLogPoint", linehl = "", numhl = "" })


-- Setup DAP with mason
local status_ok, mason_dap = pcall(require, "mason-nvim-dap")
if not status_ok then
  vim.notify("Failed to load mason-nvim-dap", vim.log.levels.ERROR)
  return
end


local status_ok, servers = pcall(require, "nvshan.plugins.dap.servers")
if not status_ok then
  vim.notify("No default DAP client configured", vim.log.levels.WARN)
  servers = {}
end

local handlers = {
  function(config)
    require('mason-nvim-dap').default_setup(config)
  end,
}

-- additional pre-defined handlers
for server, opts in pairs(servers) do
  handlers[server] = function(config)
    config = vim.tbl_deep_extend("force", config, opts)
    require('mason-nvim-dap').default_setup(config)   -- don't forget this!
  end
end

mason_dap.setup(
  {
    ensure_installed = vim.tbl_keys(servers),
    automatic_installation = true,
    handlers = handlers,
  }
)

