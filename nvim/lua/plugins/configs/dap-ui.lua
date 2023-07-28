vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapUIStop', linehl = '', numhl = '', culhl = '' })
vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapUIPlayPause', linehl = '', numhl = '', culhl = '' })

local dap, dapui = require "dap", require "dapui"
dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
dapui.setup()

local status_ok, mason_dap = pcall(require, "mason-nvim-dap")
if not status_ok then
  return
end
mason_dap.setup(
  {
    ensure_installed = { "python" },
    handlers = {
      function(config)
        mason_dap.default_setup(config)
      end,
    },
    python = function(config)
      config.adaptors = {
        type = "executable",
        command = "python3",
        args = { "-m", "debugpy.adapter", },
      }
      mason_dap.default_setup(config)
    end
  }
)
