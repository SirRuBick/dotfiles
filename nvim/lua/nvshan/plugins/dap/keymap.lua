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

local function conditional_breakpoint_toggle()
  vim.ui.input({ prompt = "Condition: " }, function(condition)
    if condition then
      require("dap").toggle_breakpoint(condition)
    end
  end)
end

local function reload_continue()
  package.loaded["nvshan.plugins.dap.dap"] = nil
  require("nvshan.plugins.dap.dap")
  require("dap").continue()
end

local function eval_input()
  vim.ui.input({ prompt = "Expression: " }, function(expr)
    if expr then
      require("dapui").eval(expr)
    end
  end)
end

mappings.n["<leader>d"] = map():desc(wk_icons.d)

-- vscode like shortcuts
mappings.n["<F5>"] = map(function()
  require("dap").continue()
end):desc("Debugger: Continue")
mappings.n["<F10>"] = map(function()
  require("dap").step_over()
end):desc("Debugger: Step Over")
mappings.n["<F11>"] = map(function()
  require("dap").step_into()
end):desc("Debugger: Step Into")
mappings.n["<S-F11>"] = map(function()
  require("dap").step_out()
end):desc("Debugger: Step Out")
mappings.n["<S-F5>"] = map(function()
  require("dap").terminate()
end):desc("Debugger: Stop")
mappings.n["<C-S-F5>"] = map(function()
  require("dap").restart_frame()
end):desc("Debugger: Restart")
mappings.n["<leader>db"] = map(function()
  require("dap").toggle_breakpoint()
end):desc("Toggle Breakpoint")
mappings.n["<leader>dB"] = map(conditional_breakpoint_toggle):desc("Conditional Breakpoint")
mappings.n["<leader>dc"] = map(function()
  require("dap.ext.vscode").load_launchjs()
  require("dap").continue()
end):desc("Continue (F5)")
mappings.n["<leader>dd"] = map(function()
  require("dap").disconnect()
end):desc("Disconnect")
mappings.n["<leader>dC"] = map(reload_continue):desc("Reload Continue")
mappings.n["<leader>di"] = map(function()
  require("dap").step_into()
end):desc("Step Into (F11)")
mappings.n["<leader>do"] = map(function()
  require("dap").step_over()
end):desc("Step Over (F10)")
mappings.n["<leader>dO"] = map(function()
  require("dap").step_out()
end):desc("Step Out (Shift-F11)")
mappings.n["<leader>dq"] = map(function()
  require("dap").close()
end):desc("Close")
mappings.n["<leader>dt"] = map(function()
  require("dap").terminate()
end):desc("Terminate (Shift-F5)")
mappings.n["<leader>dw"] = map(function()
  require("dap").clear_breakpoints()
end):desc("Clear Breakpoints")
mappings.n["<leader>dp"] = map(function()
  require("dap").pause()
end):desc("Pause")
mappings.n["<leader>dr"] = map(function()
  require("dap").restart_frame()
end):desc("Restart (C-S-F5)")
mappings.n["<leader>dl"] = map(function()
  require("dap").repl.toggle()
end):desc("Toggle REPL")
mappings.n["<leader>ds"] = map(function()
  require("dap").run_to_cursor()
end):desc("Run To Cursor")
mappings.n["<leader>dn"] = map(function()
  require("dap").run_last()
end):desc("Run Last")
mappings.n["<leader>dj"] = map(function()
  require("dap.ext.vscode").load_launchjs()
end):desc("Load Launch Json")
mappings.n["<leader>dh"] = map(function()
  require("dap.ui.widgets").hover()
end):desc("Debugger Hover")
mappings.n["<leader>df"] = map(function()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.frames)
end):desc("Debugger Preview")
mappings.n["<leader>dS"] = map(function()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.scopes)
end):desc("Debugger Preview")

-- DAP-UI
if not is_available("nvim-dap-ui") then
  vim.notify("nvim-dap-ui is available", vim.log.levels.WARN)
  return mappings
end
mappings.n["<leader>de"] = map(eval_input):desc("Evaluate Input")
mappings.n["<leader>du"] = map(function()
  require("dapui").toggle()
end):desc("Toggle DAP UI")

return mappings
