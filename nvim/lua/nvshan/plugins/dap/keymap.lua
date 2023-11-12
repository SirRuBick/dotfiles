local is_available = require("utils").is_available
local keymap_utils = require("nvshan.keymap.utils")
local mappings = keymap_utils.init_mapping()
local map = keymap_utils.map
local wk_icons = require("icons")["whichkey"]


-- DAP
if not is_available("nvim-dap") then
  vim.notify("Failed to load nvim-dap", vim.log.levels.ERROR)
  return {}
end

mappings.n["<leader>d"] = map():desc(wk_icons.d)
mappings.v["<leader>d"] = map():desc(wk_icons.d)
mappings.n["<F5>"] = map(function() require("dap").continue() end):desc("Debugger: Start")
mappings.n["<F6>"] = map(function() require("dap").step_over() end):desc("Debugger: Step Over")
mappings.n["<F7>"] = map(function() require("dap").step_into() end):desc("Debugger: Step Into")
mappings.n["<F8>"] = map(function() require("dap").step_out() end):desc("Debugger: Step Out")
mappings.n["<F9>"] = map(function() require("dap").pause() end):desc("Debugger: Pause")
mappings.n["C-<F9>"] = map(function() require("dap").terminate() end):desc("Debugger: Stop")
mappings.n["C-<F5>"] = map(function() require("dap").restart_frame() end):desc("Debugger: Restart")
mappings.n["<leader>dB"] = map( -- Shift+F9
  function()
    vim.ui.input({ prompt = "Condition: " }, function(condition)
      if condition then require("dap").set_breakpoint(condition) end
    end)
  end):desc("Debugger: Conditional Breakpoint")
mappings.n["<leader>db"] = map(function() require("dap").toggle_breakpoint() end):desc("Toggle Breakpoint (F9)")
mappings.n["<leader>dC"] = map(function() require("dap").clear_breakpoints() end):desc("Clear Breakpoints")
mappings.n["<leader>dc"] = map(function() require("dap").continue() end):desc("Debugger: Continue (F5)")
mappings.n["<leader>di"] = map(function() require("dap").step_into() end):desc("Step Into (F7)")
mappings.n["<leader>do"] = map(function() require("dap").step_over() end):desc("Step Over (F6)")
mappings.n["<leader>dO"] = map(function() require("dap").step_out() end):desc("Step Out (F8)")
mappings.n["<leader>dq"] = map(function() require("dap").close() end):desc("Close Session")
mappings.n["<leader>dQ"] = map(function() require("dap").terminate() end):desc("Terminate Session (C-F9)")
mappings.n["<leader>dp"] = map(function() require("dap").pause() end):desc("Pause (F9)")
mappings.n["<leader>dr"] = map(function() require("dap").restart_frame() end):desc("Restart (C-F5)")
mappings.n["<leader>dR"] = map(function() require("dap").repl.toggle() end):desc("Toggle REPL")
mappings.n["<leader>ds"] = map(function() require("dap").run_to_cursor() end):desc("Run To Cursor")
mappings.n["<leader>dl"] = map(function() require("dap").run_last() end):desc("Run Last")


-- DAP-UI
if not is_available("nvim-dap-ui") then
  vim.notify("nvim-dap-ui is available", vim.log.levels.WARN)
  return mappings
end

mappings.n["<leader>dE"] = map(
  function()
    vim.ui.input({ prompt = "Expression: " }, function(expr)
      if expr then require("dapui").eval(expr) end
    end)
  end):desc("Evaluate Input")
-- mappings.v["<leader>dE"] = map(function() require("dapui").eval() end):desc("Evaluate Input" }
mappings.n["<leader>du"] = map(function() require("dapui").toggle() end):desc("Toggle Debugger UI")
mappings.n["<leader>dh"] = map(function() require("dap.ui.widgets").hover() end):desc("Debugger Hover")


return mappings